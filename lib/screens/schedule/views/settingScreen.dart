import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.purple[50],
      ),
      body: const Center(
        child: Text(
          'Settings Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}