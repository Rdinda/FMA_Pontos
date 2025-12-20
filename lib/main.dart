import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/sync_repository.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://hlvvazkgzzoichdgkszf.supabase.co',
    anonKey: 'sb_publishable_XY51Jp2zfA7GJ85r-THEkA_e_XbpBnY',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SyncRepository())],
      child: MaterialApp(
        title: 'Filhos de Maria das Almas',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        locale: const Locale('pt', 'BR'),
        themeMode: ThemeMode.light,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color(0xFF6200EE),
          scaffoldBackgroundColor: Colors.grey[50],
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6200EE),
            brightness: Brightness.light,
          ),
          textTheme: GoogleFonts.outfitTextTheme(),
          appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xFF6200EE),
            foregroundColor: Colors.white,
            elevation: 2,
            titleTextStyle: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          useMaterial3: true,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF6200EE), width: 2),
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
