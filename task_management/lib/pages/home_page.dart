import 'package:flutter/material.dart';
import 'package:task_management/auth/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout(){
    // get auth service
    final auth = AuthService();
    auth.signOut();
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
              onPressed: logout,
              icon: const Icon(Icons.logout)),
        ],
      ),
    );
  }
}
