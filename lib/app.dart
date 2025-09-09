import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitra_pix/features/auth/data/firebase_auth_repo.dart';
import 'package:mitra_pix/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mitra_pix/features/auth/presentation/cubits/auth_states.dart';
import 'package:mitra_pix/features/auth/presentation/pages/auth_page.dart';
import 'package:mitra_pix/features/posts/presentation/pages/home_page.dart';
import 'package:mitra_pix/themes/light_mode.dart';

/* 
  App - Root level widget

  Repositories: for databaase
    - Firebase
  
  Bloc: for state management
    - AuthCubit: for authentication (login, register, logout)
    - profile
    - posts
    - theme
    - search

  Check Auth state
    - if user is logged in, show home page
    - if user is not logged in, show auth page (login/register)

*/

class MyApp extends StatelessWidget {
  // auth repo
  final authRepo = FirebaseAuthRepo();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightMode,
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            print(authState);

            // if user is unauthenticated, show auth page
            if (authState is Unauthenticated) {
              return const AuthPage();
            }

            // if user is authenticated, show home page
            else if (authState is Authenticated) {
              return const HomePage();
            }

            // loading
            else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          listener: (context, state) {
            if (state is AuthError) {
              final snackBar = SnackBar(content: Text(state.message));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
        ),
      ),
    );
  }
}
