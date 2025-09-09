import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitra_pix/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mitra_pix/features/posts/components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {context.read<AuthCubit>().logout();},
            icon: const Icon(Icons.logout),
          )
        ],
      ),

      drawer: MyDrawer(),
    );
  }
}
