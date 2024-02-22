import 'package:teraflex_mobile/features/notifications/domain/entities/notification.dart';
import 'package:teraflex_mobile/features/notifications/infrastructure/models/tfx/tfx_notification_model.dart';

class NotificationMapper {
  static List<MyNotification> fromTfxNotification(TfxNotificationModel model) {
    return model.data
        .map((e) => MyNotification(
              id: e.id,
              title: e.title,
              body: e.body,
              sendDate: e.createdAt,
              status: e.status,
            ))
        .toList();
  }
}
