import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Stream<User?> authStateChanges();
  Future<User?> signUp({required String email, required String password});
  Future<User?> signIn({required String email, required String password});
  Future<void> signOut();
  User? getCurrentUser();
}

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<User?> authStateChanges() =>
    _firebaseAuth.authStateChanges();

  @override
  Future<User?> signUp({required String email, required String password}) async {
    try {
      final cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<User?> signIn({required String email, required String password}) async {
    try {
      final cred = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();

  @override
  User? getCurrentUser() => _firebaseAuth.currentUser;
}