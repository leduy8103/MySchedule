import 'package:flutter/material.dart';
import 'package:task_mgt/components/my_button.dart';
import 'package:task_mgt/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  void login(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.green.shade300,
                      shape: BoxShape.circle,
                    ),
                  )
              ),
              Positioned(
                  top: 10,
                  left: 270,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                right: 280,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 320,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Please sign in to continue',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 50),
                        MyTextField(
                          hintText: 'Email',
                          icon: const Icon(Icons.mail_outline),
                          controller: _emailController,
                          obsecureText: false,
                        ),
                        MyTextField(
                          hintText: 'Email',
                          icon: const Icon(Icons.lock_outline),
                          controller: _passwordController,
                          obsecureText: false,
                        ),
                        const SizedBox(height: 25),
                        MyButton(
                          text: 'Login',
                          onPressed: login,
                        ),
                        const SizedBox(height: 25,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Not a member?'),
                            GestureDetector(
                              onTap: onTap,
                              child: Text(
                                'Register now',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade300,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                ),
              )
            ],
      )),
    );
  }
}