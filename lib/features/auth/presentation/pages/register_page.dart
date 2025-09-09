import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitra_pix/features/auth/presentation/components/my_button.dart';
import 'package:mitra_pix/features/auth/presentation/components/my_text_field.dart';
import 'package:mitra_pix/features/auth/presentation/cubits/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? toggletPages;
  const RegisterPage({super.key, required this.toggletPages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user in method
  void register() {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    // auth cubit
    final authCubit = context.read<AuthCubit>();

    // ensure name, email and password are not empty
    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {

      if(password == confirmPassword){
        authCubit.register(name, email, password);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Password and Confirm Password do not match"),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please Enter Name, Email and Password"),
      ));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
              // create an account message

              Text("Let's create an account for you!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  )),

              const SizedBox(height: 50),

              // email textfield
              MyTextField(
                  controller: nameController,
                  hintText: "Name",
                  obscureText: false),

              const SizedBox(height: 10),

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

              const SizedBox(height: 10),
              // password textfield
              MyTextField(
                  controller: confirmPasswordController,
                  hintText: "confirm password",
                  obscureText: true),

              const SizedBox(height: 25),

              // login button
              MyButton(onTap: register, text: "Sign Up"),

              const SizedBox(height: 50),

              // go to register page
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already a member?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  GestureDetector(
                    onTap: widget.toggletPages,
                    child: Text(" Login now",
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
