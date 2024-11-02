import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/blocs/authentication_bloc/authentication_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void logout(BuildContext context) {
    context.read<AuthenticationBloc>().add(AuthenticationLogoutRequest());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        foregroundColor: Colors.white,
        title: const Text('Home page'),
        actions: [
          IconButton(
              onPressed: () => logout(context), icon: const Icon(Icons.logout)),
        ],
      ),
    );
  }
}
