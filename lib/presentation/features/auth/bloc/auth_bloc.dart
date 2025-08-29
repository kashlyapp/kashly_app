import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kashly_app/data/services/auth_service.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  StreamSubscription<User?>? _userSubscription;

  AuthBloc({required AuthService authService})
      : _authService = authService,
        super(const AuthInitial()) {
    _userSubscription = _authService.authStateChanges.listen((user) {
      add(AuthStatusChanged(user));
    });

    on<AuthStatusChanged>((event, emit) {
      if (event.user != null) {
        emit(AuthAuthenticated(event.user!));
      } else {
        emit(const AuthUnauthenticated());
      }
    });

    on<AuthSignUpRequested>(_onAuthSignUpRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthSignOutRequested>(_onAuthSignOutRequested);
    on<AuthPasswordResetRequested>(_onAuthPasswordResetRequested);
    on<AuthGoogleSignInRequested>(_onAuthGoogleSignInRequested);
  }

  Future<void> _onAuthSignUpRequested(
      AuthSignUpRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final userCredential = await _authService.signUpWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      if (userCredential == null || userCredential.user == null) {
        emit(const AuthFailure("No s'ha pogut crear l'usuari."));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Error de registre desconegut"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAuthLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final userCredential = await _authService.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      if (userCredential == null || userCredential.user == null) {
        emit(const AuthFailure("Credencials invàlides o usuari no trobat."));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Error d'inici de sessió desconegut"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAuthSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _authService.signOut();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAuthPasswordResetRequested(
    AuthPasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _authService.sendPasswordResetEmail(event.email);
      emit(const AuthUnauthenticated()); // O pots crear un estat específic si vols
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Error en enviar l'email de recuperació"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAuthGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final userCredential = await _authService.signInWithGoogle();
      if (userCredential == null || userCredential.user == null) {
        emit(const AuthFailure("No s'ha pogut iniciar sessió amb Google."));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Error d'inici de sessió amb Google"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
