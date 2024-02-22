import 'package:teraflex_mobile/features/notifications/domain/entities/notification.dart';

abstract class NotificationRepository {
  // api: notification-token/register-device
  Future<void> registerToken({required String token, required String device});

  // get notifications
  Future<List<MyNotification>> getNotifications();
}
