import 'package:teraflex_mobile/features/notifications/domain/datasources/notification_datasorce.dart';
import 'package:teraflex_mobile/features/notifications/domain/entities/notification.dart';
import 'package:teraflex_mobile/features/notifications/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationDatasorce datasource;

  NotificationRepositoryImpl({required this.datasource});

  @override
  Future<void> registerToken({required String token, required String device}) {
    return datasource.registerToken(token: token, device: device);
  }

  @override
  Future<List<MyNotification>> getNotifications() {
    return datasource.getNotifications();
  }
}
