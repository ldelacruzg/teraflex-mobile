import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends StatelessWidget {
  static String name = 'setting_screen';

  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Información personal'),
            subtitle: const Text('Nombre, correo, etc'),
            leading: const CircleAvatar(child: Icon(Icons.person_rounded)),
            trailing: const Icon(Icons.arrow_forward_rounded),
            onTap: () {
              context.push('/settings/profile');
            },
          ),
          ListTile(
            title: const Text('Seguridad'),
            subtitle: const Text('Contraseña, bloqueo, etc'),
            leading: const CircleAvatar(child: Icon(Icons.security_rounded)),
            trailing: const Icon(Icons.arrow_forward_rounded),
            onTap: () {
              context.push('/settings/security');
            },
          ),
          ListTile(
            title: const Text('Sobre TeraFlex'),
            subtitle: const Text('Versión, licencia, etc'),
            leading: const CircleAvatar(child: Icon(Icons.info_rounded)),
            trailing: const Icon(Icons.arrow_forward_rounded),
            onTap: () {
              context.push('/settings/about');
            },
          ),
          ListTile(
            title: const Text('Cerrar Sesión'),
            subtitle: const Text('Cerrar sesión en TeraFlex'),
            leading: const CircleAvatar(
              backgroundColor: Color.fromRGBO(218, 31, 31, 0.15),
              child: Icon(
                Icons.logout_rounded,
                color: Color.fromRGBO(218, 31, 31, 1),
              ),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
