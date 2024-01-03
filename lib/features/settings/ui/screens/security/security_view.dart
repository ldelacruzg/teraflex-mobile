import 'package:flutter/material.dart';

class SecurityScreen extends StatelessWidget {
  static String name = 'security_screen';

  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguridad'),
      ),
      body: const Center(
        child: Text('Security Screen'),
      ),
    );
  }
}
