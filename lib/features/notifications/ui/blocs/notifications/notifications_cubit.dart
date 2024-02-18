import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:teraflex_mobile/features/notifications/domain/push_message.dart';
import 'package:teraflex_mobile/firebase_options.dart';

part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
  // TODO: realizar petición para guardar la notificación en el backend
}

class NotificationsCubit extends Cubit<NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsCubit() : super(const NotificationsState()) {
    _initialStatusCheck();
    _onForegroundMessage();
  }

  static Future<void> initializeFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _notificationStatusChanged(AuthorizationStatus newStatus) {
    emit(state.copyWith(status: newStatus));
    _getFCMToken();
    // TODO: Hacer petición al backend para guardar el token
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    _notificationStatusChanged(settings.authorizationStatus);
  }

  void _getFCMToken() async {
    if (state.status != AuthorizationStatus.authorized) return;
    final token = await messaging.getToken();
    print('FCM Token: $token');
  }

  void _handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;
    final newNotification = PushMessage(
      messageId:
          message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
      title: message.notification!.title ?? '',
      body: message.notification!.body ?? '',
      sendDate: message.sentTime ?? DateTime.now(),
      data: message.data,
    );

    // TODO: realizar petición para guardar la notificación en el backend
    _onPushNotificationReceived(newNotification);
  }

  void _onPushNotificationReceived(PushMessage newNotification) {
    emit(state.copyWith(
      notifications: [newNotification, ...state.notifications],
    ));
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
  }

  requestPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    _notificationStatusChanged(settings.authorizationStatus);
  }
}
