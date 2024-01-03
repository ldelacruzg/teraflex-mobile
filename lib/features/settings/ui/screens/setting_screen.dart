import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  static String name = 'setting_screen';
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: const Center(
        child: Text('Setting Screen'),
      ),
    );
  }
}
