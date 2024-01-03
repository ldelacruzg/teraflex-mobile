import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static String name = 'profile_screen';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información Personal'),
      ),
      body: const Center(
        child: Text('Información Personal'),
      ),
    );
  }
}
