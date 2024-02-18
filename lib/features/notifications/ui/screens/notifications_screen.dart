import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teraflex_mobile/features/notifications/domain/push_message.dart';
import 'package:teraflex_mobile/features/notifications/ui/blocs/notifications/notifications_cubit.dart';

class NotificationsScreen extends StatelessWidget {
  static const String name = 'notifications_screen';

  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NotificationsCubit>().state;
    final notificationLength = state.notifications.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
      ),
      body: notificationLength > 0
          ? NotificationView(notifications: state.notifications)
          : const Center(child: Text('No hay notificaciones')),
    );
  }
}

class NotificationView extends StatelessWidget {
  final List<PushMessage> notifications;

  const NotificationView({
    super.key,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return ListTile(
          title: Text(notification.title),
          subtitle: Text(notification.body),
          leading: const CircleAvatar(
            child: Icon(Icons.notifications),
          ),
        );
      },
    );
  }
}
