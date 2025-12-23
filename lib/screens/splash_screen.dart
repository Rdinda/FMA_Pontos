import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../services/sync_repository.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkPermissionsAndNavigate();
  }

  Future<void> _checkPermissionsAndNavigate() async {
    // Wait a bit for the splash effect
    await Future.delayed(const Duration(seconds: 2));

    // Request permissions for audio/storage
    // Android 13+ use PHOTOS/AUDIO/VIDEO permissions, older use STORAGE
    await [
      Permission.storage,
      Permission.audio,
      // Add other media permissions if necessary for Android 13+ specifically if audio isn't enough,
      // but 'audio' permission handler maps correctly usually.
    ].request();

    // We proceed regardless of acceptance for now, or you can block.
    // Usually good UX to proceed and ask again when action attempts it if denied.
    // But since "it MUST be requested", we do it here.

    if (mounted) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Consumer<SyncRepository>(
              builder: (context, syncRepo, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Image
                    Image.asset(
                      'assets/images/splash.png',
                      width: 300,
                      height: 300,
                    ),
                    const SizedBox(height: 24),
                    // Loader
                    const CupertinoActivityIndicator(
                      radius: 15.0,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    if (syncRepo.isDownloading) ...[
                      Text(
                        syncRepo.downloadStatus,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48.0),
                        child: LinearProgressIndicator(
                          value: syncRepo.downloadProgress,
                        ),
                      ),
                    ] else
                      const Text(
                        "Carregando...",
                        style: TextStyle(color: Colors.grey),
                      ),
                  ],
                );
              },
            ),
          ),
          const Positioned(
            bottom: 16,
            right: 16,
            child: Text(
              "v1.0.4",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
