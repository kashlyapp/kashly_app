import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kashly_app/data/services/auth_service.dart';
import 'package:kashly_app/firebase_options.dart';
import 'package:kashly_app/presentation/features/auth/bloc/auth_bloc.dart';
import 'package:kashly_app/presentation/features/auth/bloc/auth_state.dart'; // Afegida importació directa
import 'package:kashly_app/presentation/features/auth/pages/login_page.dart';
import 'package:kashly_app/presentation/features/dashboard/pages/dashboard_page.dart';

Future<void> main() async {
  // Assegura’t que Flutter estigui inicialitzat
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialitza Firebase amb les opcions per la plataforma
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Permet definir la siteKey per entorn; fa fallback a la clau actual si no es passa
  const siteKey = String.fromEnvironment(
    'APP_CHECK_WEB_SITE_KEY',
    defaultValue: '6LdConQrAAAAAPEfH6TE-XvERXZ2Fn7jo7vGtudC',
  );

  // Permet escollir el proveïdor d'App Check per plataforma via --dart-define
  // Android: 'debug' (per defecte) o 'playIntegrity'
  const androidProviderEnv = String.fromEnvironment(
    'APP_CHECK_ANDROID_PROVIDER',
    defaultValue: 'debug',
  );
  // iOS: 'deviceCheck' (per defecte) o 'appAttest'
  const appleProviderEnv = String.fromEnvironment(
    'APP_CHECK_APPLE_PROVIDER',
    defaultValue: 'deviceCheck',
  );

  // Opcional: força tancar sessió a l'arrencada per mostrar primer el login
  const forceLogoutOnStart = bool.fromEnvironment('FORCE_LOGOUT_ON_START', defaultValue: false);
  if (forceLogoutOnStart) {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (_) {}
  }

  if (kIsWeb) {
    // Activa App Check per a web amb reCAPTCHA
    try {
      await FirebaseAppCheck.instance.activate(
        webProvider: ReCaptchaV3Provider(siteKey),
      );
    } catch (e) {
      // No bloquejar l'app en cas d'error d'inicialització; es veurà a la consola
      // ignore: avoid_print
      print('AppCheck (web) no s\'ha pogut inicialitzar: $e');
    }
  } else {
    // Activa App Check DESPRÉS d'inicialitzar FirebaseApp per a Android/iOS
    final AndroidProvider androidProvider =
        androidProviderEnv.toLowerCase() == 'playintegrity'
            ? AndroidProvider.playIntegrity
            : AndroidProvider.debug;
    final AppleProvider appleProvider = () {
      final v = appleProviderEnv.toLowerCase();
      if (v == 'appattest') return AppleProvider.appAttest;
      return AppleProvider.deviceCheck; // per defecte
    }();

    await FirebaseAppCheck.instance.activate(
      androidProvider: androidProvider,
      appleProvider: appleProvider,
    );
  }

  final authService = AuthService(); // Crea la instància del teu AuthService

  runApp(MyApp(authService: authService));
}

class MyApp extends StatelessWidget {
  final AuthService authService;

  const MyApp({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(authService: authService),
      child: MaterialApp(
        title: 'Kashly',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthWrapper(), // AuthWrapper gestionarà la navegació inicial
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>( // AuthState hauria de ser reconegut ara
      builder: (context, state) {
        if (state is AuthAuthenticated) { // AuthAuthenticated hauria de ser reconegut ara
          return const DashboardPage(); // Usuari autenticat, va al Dashboard
        }
        // En qualsevol altre cas (AuthInitial, AuthUnauthenticated, AuthLoading, AuthFailure)
        // mostra la LoginPage.
        return const LoginPage();
      },
    );
  }
}