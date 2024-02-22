import 'package:teraflex_mobile/features/notifications/domain/entities/notification.dart';

abstract class NotificationDatasorce {
  // api: notification-token/register-device
  Future<void> registerToken({required String token, required String device});

  // eliminar notificación
  Future<void> deleteNotification({required int id});

  // obtener notificaciones
  Future<List<MyNotification>> getNotifications();
}
