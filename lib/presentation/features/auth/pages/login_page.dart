import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kashly_app/presentation/features/auth/bloc/auth_bloc.dart';
import 'package:kashly_app/presentation/features/auth/bloc/auth_event.dart'; // Afegida importació directa
import 'package:kashly_app/presentation/features/auth/bloc/auth_state.dart'; // Afegida importació directa

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isSignUpMode = false; // Nou estat per alternar entre login i registre

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthLoginRequested(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ));
    }
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Les contrasenyes no coincideixen')),
        );
        return;
      }
      context.read<AuthBloc>().add(
        AuthSignUpRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  void _toggleMode() {
    setState(() {
      _isSignUpMode = !_isSignUpMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isSignUpMode ? 'Registrar-se' : 'Iniciar Sessió')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.message)),
              );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Si us plau, introdueix el teu email';
                    }
                    // Regex bàsic per validar email (sense caràcter invisible)
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Si us plau, introdueix un email vàlid (ex: nom@domini.com)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Contrasenya'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Si us plau, introdueix la teva contrasenya';
                    }
                    if (value.length < 8) {
                      return 'La contrasenya ha de tenir almenys 8 caràcters';
                    }
                    // Validació de contrasenya forta (corregit)
                    final strongRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
                    if (!strongRegex.hasMatch(value)) {
                      return 'Ha de contenir majúscula, minúscula, número i símbol (!@#\$&*~)';
                    }
                    return null;
                  },
                ),
                if (_isSignUpMode) ...[
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(labelText: 'Repeteix la contrasenya'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Repeteix la contrasenya';
                      }
                      if (value != _passwordController.text) {
                        return 'Les contrasenyes no coincideixen';
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isSignUpMode ? _signUp : _login,
                  child: Text(_isSignUpMode ? 'Registrar-se' : 'Iniciar Sessió'),
                ),
                if (!_isSignUpMode) ...[
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    icon: Image.asset(
                      'assets/google_logo.png',
                      height: 20,
                      width: 20,
                    ),
                    label: const Text(
                      'Inicia sessió amb Google',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      elevation: 1.5,
                      minimumSize: const Size(0, 44),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () {
                      context.read<AuthBloc>().add(const AuthGoogleSignInRequested());
                    },
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () async {
                      final emailController = TextEditingController(text: _emailController.text);
                      final result = await showDialog<String>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Recuperar contrasenya'),
                          content: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(labelText: 'Introdueix el teu email'),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel·la'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(emailController.text.trim()),
                              child: const Text('Envia'),
                            ),
                          ],
                        ),
                      );
                      if (!context.mounted) return;
                      if (result != null && result.isNotEmpty) {
                        context.read<AuthBloc>().add(AuthPasswordResetRequested(result));
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Sol·licitud enviada'),
                            content: const Text('Si existeix un compte amb aquest email, t’hem enviat instruccions per restablir la contrasenya.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('D’acord'),
                              ),
                            ],
                          ),
                        );
                        if (!context.mounted) return;
                        // Torna al mode login si estava en registre
                        if (_isSignUpMode) {
                          setState(() {
                            _isSignUpMode = false;
                          });
                        }
                      }
                    },
                    child: const Text('He oblidat la contrasenya?'),
                  ),
                ],
                const SizedBox(height: 12),
                TextButton(
                  onPressed: _toggleMode,
                  child: Text(_isSignUpMode
                      ? 'Ja tens un compte? Iniciar sessió'
                      : 'No tens un compte? Registrar-se'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
