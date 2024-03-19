import 'package:flutter/material.dart';
import 'package:music_app/features/authentication/presentation/controller/authentication_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          context.read<AuthenticationProvider>().signOut();
        },
        child: const Text('Logout'),
      )),
    );
  }
}
