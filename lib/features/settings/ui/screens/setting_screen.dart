import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/datasources/isardb_login_local_storage_datasource.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/repositories/login_local_storage_repository_impl.dart';
import 'package:teraflex_mobile/features/auth/ui/blocs/auth/auth_cubit.dart';

final _loginLocalRepository = LoginLocalStorageRepositoryImpl(
  datasource: IsarDBLoginLocalStorageDatasource(),
);

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
              context.read<AuthCubit>().loadUserFromLocalStorage();
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
            onTap: () {
              // modal to confirm logout
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const LogoutDialog(),
              );
            },
          )
        ],
      ),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cerrar Sesión'),
      content: const Text('¿Estás seguro de cerrar sesión?'),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            _loginLocalRepository.logout().then((value) => context.go('/'));
          },
          child: const Text('Si'),
        ),
      ],
    );
  }
}
