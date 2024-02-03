import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SecurityScreen extends StatelessWidget {
  static String name = 'security_screen';

  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguridad'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Cambiar contraseña'),
            trailing: const Icon(Icons.arrow_forward_rounded),
            onTap: () {
              context.push('/settings/security/change-password');
            },
          )
        ],
      ),
    );
  }
}
