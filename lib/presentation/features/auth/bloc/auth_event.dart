import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// Event per notificar canvis en l'estat d'autenticació (des de Firebase)
class AuthStatusChanged extends AuthEvent {
  final User? user;

  const AuthStatusChanged(this.user);

  @override
  List<Object> get props => [user ?? Object()];
}

// Event per sol·licitar el tancament de sessió
class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}

// Event per sol·licitar el registre amb email i contrasenya
class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthSignUpRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// Event per sol·licitar inici de sessió amb email i contrasenya
class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// Event per sol·licitar reset de contrasenya
class AuthPasswordResetRequested extends AuthEvent {
  final String email;
  const AuthPasswordResetRequested(this.email);

  @override
  List<Object> get props => [email];
}

// Event per sol·licitar login amb Google
class AuthGoogleSignInRequested extends AuthEvent {
  const AuthGoogleSignInRequested();
}
