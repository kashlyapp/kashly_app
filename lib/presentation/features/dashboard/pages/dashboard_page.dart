import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kashly_app/presentation/features/auth/bloc/auth_bloc.dart';
import 'package:kashly_app/presentation/features/auth/bloc/auth_event.dart';
import 'package:kashly_app/presentation/features/auth/bloc/auth_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    String userEmail = "No disponible";
    String userId = "No disponible";

    if (authState is AuthAuthenticated) {
      userEmail = authState.user.email ?? "No disponible";
      userId = authState.user.uid;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kashly Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(const AuthSignOutRequested());
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Benvingut/da al Dashboard!'),
            const SizedBox(height: 16),
            Text('Email: $userEmail'),
            Text('UID: $userId'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.read<AuthBloc>().add(const AuthSignOutRequested()),
              child: const Text('Tancar Sessió (Prova)'),
            )
          ],
        ),
      ),
    );
  }
}
