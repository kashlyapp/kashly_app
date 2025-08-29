import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Stream per escoltar els canvis en l'estat d'autenticació
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Obtenir l'usuari actual
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // Iniciar sessió amb email i contrasenya
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Gestionar errors específics
      if (e.code == 'user-not-found') {
        // print('Error en iniciar sessió: No s\\'ha trobat cap usuari per a aquest correu electrònic.');
      } else if (e.code == 'wrong-password') {
        // print('Error en iniciar sessió: Contrasenya incorrecta.');
      } else if (e.code == 'invalid-email') {
        // print('Error en iniciar sessió: El format del correu electrònic no és vàlid.');
      } else if (e.code == 'user-disabled') {
        // print('Error en iniciar sessió: Aquest usuari ha estat desactivat.');
      } else if (e.code == 'invalid-credential') {
        // Aquest codi pot aparèixer en versions més noves o configuracions específiques
        // en lloc de 'user-not-found' o 'wrong-password'.
        // print('Error en iniciar sessió: Les credencials proporcionades són invàlides.');
      }
      else {
        // print('Error en iniciar sessió (FirebaseAuthException): ${e.code} - ${e.message}');
      }
      return null;
    } catch (_) { // 'e' canviada a '_' ja que no s'utilitza
      // print('Error desconegut en iniciar sessió: $_');
      return null;
    }
  }

  // Registrar un nou usuari amb email i contrasenya
  Future<UserCredential?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Gestionar errors específics
      if (e.code == 'weak-password') {
        // print('Error en el registre: La contrasenya proporcionada és massa dèbil.');
      } else if (e.code == 'email-already-in-use') {
        // print('Error en el registre: El correu electrònic ja està en ús per un altre compte.');
      } else if (e.code == 'invalid-email') {
        // print('Error en el registre: El format del correu electrònic no és vàlid.');
      } else {
        // print('Error en el registre (FirebaseAuthException): ${e.code} - ${e.message}');
      }
      return null;
    } catch (_) { // 'e' canviada a '_' ja que no s'utilitza
      // print('Error desconegut en el registre: $_');
      return null;
    }
  }

  // Tancar la sessió actual
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException { // 'catch (e)' eliminat ja que 'e' no s'utilitza
      // print('Error en tancar la sessió FirebaseAuthException: ${e.code} - ${e.message}');
      // Considera com gestionar aquest error, encara que és menys comú aquí.
    } catch (_) { // 'e' canviada a '_' ja que no s'utilitza
      // print('Error desconegut en tancar la sessió: $_');
    }
  }

  // Enviar email de reset de contrasenya
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  // Iniciar sessió amb Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        try {
          return await _firebaseAuth.signInWithPopup(googleProvider);
        } on FirebaseAuthException catch (e) {
          // Fallback si el navegador bloqueja el popup o l'usuari el tanca
          if (e.code == 'popup-blocked' || e.code == 'popup-closed-by-user') {
            await _firebaseAuth.signInWithRedirect(googleProvider);
            return null; // el resultat arribarà després del redirect
          }
          rethrow;
        }
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          return null;
        }
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        return await _firebaseAuth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
  debugPrint('[AuthService] Google sign-in FirebaseAuthException: ${e.code} - ${e.message}');
      return null;
    } catch (e) {
  debugPrint('[AuthService] Google sign-in unknown error: $e');
      return null;
    }
  }

  // TODO: Implementar altres mètodes d'autenticació si són necessaris (Google, Apple, etc.)
  // Future<UserCredential?> signInWithApple() async { ... }
}