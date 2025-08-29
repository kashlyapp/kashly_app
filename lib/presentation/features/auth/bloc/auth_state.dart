import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// Estat inicial, abans de determinar l'estat d'autenticació
class AuthInitial extends AuthState {
  const AuthInitial();
}

// Estat mentre s'està processant una operació d'autenticació (p.ex. login)
class AuthLoading extends AuthState {
  const AuthLoading();
}

// Estat quan l'usuari està autenticat
class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

// Estat quan l'usuari no està autenticat
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

// Estat quan hi ha hagut un error durant el procés d'autenticació
class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}
