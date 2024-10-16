import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_mgt/screens/login_screen.dart';

import '../screens/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            //user is loggin in
            if(snapshot.hasData){
              return const HomePage();
            }
            else{
              return LoginPage();
            }
          }),
    );
  }
}
