/*
  At this page - show which page should be opened first - login or register
*/

import 'package:flutter/material.dart';
import 'package:mitra_pix/features/auth/presentation/pages/login_page.dart';
import 'package:mitra_pix/features/auth/presentation/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initially show login page
  bool showLoginPage = true;

  // toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(toggletPages: togglePages,);
    } else {
      return RegisterPage(toggletPages: togglePages,);
    }
  }
}
