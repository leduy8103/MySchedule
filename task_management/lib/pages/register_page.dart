import 'package:flutter/material.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:task_management/components/my_button.dart';
import 'package:task_management/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) async{
    //auth service
    final auth = AuthService();

    if(_passwordController.text == _confirmPasswordController.text){
      try{
        await auth.signUpWithEmailPassword(_emailController.text, _passwordController.text);
      }
      catch(e){
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            ));
      }
    }
    else{
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text('Passwords does not match!'),
          ));
    }
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
                          'Create Account',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        MyTextField(
                          hintText: 'Email',
                          icon: const Icon(Icons.mail_outline),
                          controller: _emailController,
                          obsecureText: false,
                        ),
                        const SizedBox(height: 25,),
                        MyTextField(
                          hintText: 'Password',
                          icon: const Icon(Icons.lock_outline),
                          controller: _passwordController,
                          obsecureText: true,
                        ),
                        const SizedBox(height: 25),
                        MyTextField(
                          hintText: 'Confirm Password',
                          icon: const Icon(Icons.lock_outline),
                          controller: _confirmPasswordController,
                          obsecureText: true,
                        ),
                        const SizedBox(height: 25),
                        MyButton(
                          text: 'Register',
                          onPressed: () =>register(context),
                        ),
                        const SizedBox(height: 25,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?'),
                            GestureDetector(
                              onTap: onTap,
                              child: Text(
                                'Login now',
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
