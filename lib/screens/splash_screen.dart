import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../services/sync_repository.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
    _checkPermissionsAndNavigate();
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _version = packageInfo.version;
      });
    }
  }

  Future<void> _checkPermissionsAndNavigate() async {
    // Wait a bit for the splash effect
    await Future.delayed(const Duration(seconds: 2));

    // Request permissions for audio/storage
    await [Permission.storage, Permission.audio].request();

    if (!mounted) return;

    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.ensureAuthenticated();

    final prefs = await SharedPreferences.getInstance();
    final hasCompletedOnboarding =
        prefs.getBool('onboarding_completed') ?? false;

    if (!mounted) return;

    final nextScreen =
        hasCompletedOnboarding ? const HomeScreen() : const OnboardingScreen();

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => nextScreen));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
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
                    CupertinoActivityIndicator(
                      radius: 15.0,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    if (syncRepo.isDownloading) ...[
                      Text(
                        syncRepo.downloadStatus,
                        style: TextStyle(color: colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48.0),
                        child: LinearProgressIndicator(
                          value: syncRepo.downloadProgress,
                        ),
                      ),
                    ] else
                      Text(
                        "Carregando...",
                        style: TextStyle(color: colorScheme.onSurfaceVariant),
                      ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Text(
              _version.isNotEmpty ? "v$_version" : "",
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
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
