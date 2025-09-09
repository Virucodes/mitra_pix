/*
  LOGIN PAGE

  on this page an existing user can login with email and password:

  - email
  - password

-------------------------------------------------------------------------------------------------------------------

  Once the user is logged in, they are redirected to the home page.

  If the user does not have an account, they can navigate to the register page.

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitra_pix/features/auth/presentation/components/my_button.dart';
import 'package:mitra_pix/features/auth/presentation/components/my_text_field.dart';
import 'package:mitra_pix/features/auth/presentation/cubits/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  final void Function()? toggletPages;
  const LoginPage({super.key, required this.toggletPages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // login button pressed
  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // auth cubit
    final authCubit = context.read<AuthCubit>();

    // ensuere email and password are not empty
    if (email.isNotEmpty && password.isNotEmpty) {
      authCubit.login(email, password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please Enter Email and Password"),
      ));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_open_rounded,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 50),
              // welcome back message

              Text("Welcome back you've been missed!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  )),

              const SizedBox(height: 50),

              // email textfield
              MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                  controller: passwordController,
                  hintText: "password",
                  obscureText: true),

              const SizedBox(height: 50),

              // login button
              MyButton(onTap: login, text: "Sign In"),

              const SizedBox(height: 50),

              // go to register page
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  GestureDetector(
                    onTap: widget.toggletPages,
                    child: Text(" Register now",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
