import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teraflex_mobile/features/notifications/domain/entities/notification.dart';
import 'package:teraflex_mobile/features/notifications/ui/blocs/notifications/notifications_cubit.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

class NotificationsScreen extends StatelessWidget {
  static const String name = 'notifications_screen';

  const NotificationsScreen({super.key});

  Widget notificationView(BuildContext context) {
    final state = context.watch<NotificationsCubit>().state;
    final notificationLength = state.myNotifications.length;
    return notificationLength > 0
        ? NotificationView(notifications: state.myNotifications)
        : const Center(child: Text('No hay notificaciones'));
  }

  Widget loadingView() {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NotificationsCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
      ),
      body: state.globalStatus == StatusUtil.loading
          ? loadingView()
          : notificationView(context),
    );
  }
}

class NotificationView extends StatelessWidget {
  final List<MyNotification> notifications;

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
        return Dismissible(
          key: Key(notification.id.toString()),
          confirmDismiss: (direction) async {
            try {
              print("eliminar ${notification.id}");
              await Future.delayed(const Duration(seconds: 2));
              return Future.value(true);
              //throw Exception('Error al eliminar la notificación');
            } catch (e) {
              print("Error al eliminar ${notification.id}");
              return Future.value(false);
            }
          },
          child: ListTile(
            title: Text(notification.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.body),
                Text(
                  notification.sendDate,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            dense: true,
            leading: const CircleAvatar(
              child: Icon(Icons.notifications),
            ),
          ),
        );
      },
    );
  }
}
