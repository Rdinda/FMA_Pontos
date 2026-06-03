import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';
import 'services/sync_repository.dart';
import 'services/audio_player_service.dart';
import 'services/auth_service.dart';
import 'services/favorites_service.dart';
import 'providers/theme_provider.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
    throw Exception(
      'SUPABASE_URL e SUPABASE_ANON_KEY devem ser definidos via --dart-define',
    );
  }

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  debugPrint('[main] Initializing AudioPlayerService...');
  final audioService = await AudioPlayerService.create();
  debugPrint('[main] AudioPlayerService initialized successfully');

  runApp(MyApp(audioService: audioService));
}

EdgeInsetsGeometry _toastMarginBuilder(
  BuildContext context,
  AlignmentGeometry alignment,
) {
  return const EdgeInsets.fromLTRB(16, 0, 16, 110);
}

class MyApp extends StatelessWidget {
  final AudioPlayerService audioService;

  const MyApp({super.key, required this.audioService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProxyProvider<AuthService, SyncRepository>(
          create: (_) => SyncRepository(),
          update: (_, auth, repo) {
            repo!.bindAuth(auth);
            return repo;
          },
        ),
        ChangeNotifierProxyProvider<AuthService, FavoritesService>(
          create: (_) => FavoritesService(),
          update: (_, auth, fav) {
            fav!.bindAuth(auth);
            return fav;
          },
        ),
        ChangeNotifierProvider.value(value: audioService),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return ToastificationWrapper(
            config: const ToastificationConfig(
              alignment: Alignment.bottomCenter,
              blockBackgroundInteraction: false,
              marginBuilder: _toastMarginBuilder,
            ),
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
              themeMode: themeProvider.themeMode,
              theme: AppTheme.buildLightTheme(),
              darkTheme: AppTheme.buildDarkTheme(),
              home: const SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
