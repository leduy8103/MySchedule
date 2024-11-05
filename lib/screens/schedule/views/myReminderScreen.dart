import 'package:flutter/material.dart';

class myReminderScreen extends StatelessWidget {
  const myReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today Schedule"),
        backgroundColor: Colors.purple[50],
      ),
      body: const Center(
        child: Text(
          'Today Schedule Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
