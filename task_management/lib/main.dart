import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_management/auth/auth_gate.dart';
import 'package:task_management/auth/login_or_register.dart';
import 'package:task_management/firebase_options.dart';
import 'package:task_management/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}

