// 1. Importa Firebase Core
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// 3. Importa el teu AuthService
import 'package:kashly_app/data/services/auth_service.dart';

// 2. Importa el fitxer de configuració generat per FlutterFire CLI
import 'firebase_options.dart';

void main() async {
  // 4. Assegura’t que Flutter estigui inicialitzat
  WidgetsFlutterBinding.ensureInitialized();
  // 5. Inicialitza Firebase amb les opcions per la plataforma
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 6. Prova AuthService: imprimeix l’usuari actual a la consola
  FirebaseAuthService()
      .authStateChanges()
      .listen((user) => print('Usuari actual: $user'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kashly App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // Aquí pots posar la teva pantalla de login o splash
      home: const Scaffold(
        body: Center(child: Text('Pantalla inicial pendent')),
      ),
    );
  }
}