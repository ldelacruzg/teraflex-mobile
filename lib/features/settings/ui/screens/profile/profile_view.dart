import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teraflex_mobile/features/auth/domain/entities/user/user.dart';
import 'package:teraflex_mobile/features/auth/ui/blocs/auth/auth_cubit.dart';
import 'package:teraflex_mobile/features/notifications/ui/blocs/notifications/notifications_cubit.dart';
import 'package:teraflex_mobile/utils/date_util.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

class ProfileScreen extends StatelessWidget {
  static String name = 'profile_screen';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;

    if (authState.status == StatusUtil.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ProfileView(user: authState.user!);
  }
}

class ProfileView extends StatelessWidget {
  final User user;

  const ProfileView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final notificationState = context.watch<NotificationsCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información Personal'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              // Avatar and name
              Card(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Center(
                        child: CircleAvatar(
                          radius: 30,
                          child: Icon(Icons.person_rounded, size: 30),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.firstName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user.lastName,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // General information
              Card(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('General',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Cédula:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(user.docNumber,
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Teléfono:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(user.phone ?? '',
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Fecha de nacimiento:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  user.birthDate != null
                                      ? DateUtil.convertDate(user.birthDate!)
                                      : '',
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Description
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Diagnótico',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Text(user.description ?? 'Sin diágnostico',
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Notificaciones
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Notificaciones',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Noti ::: ${notificationState.status.name}"),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<NotificationsCubit>()
                                    .requestPermissions();
                              },
                              child: const Text('Habilitar'),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
