import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:teraflex_mobile/features/notifications/domain/entities/notification.dart';
import 'package:teraflex_mobile/features/notifications/domain/entities/push_message.dart';
import 'package:teraflex_mobile/features/notifications/infrastructure/datasources/tfx_notification_datasource.dart';
import 'package:teraflex_mobile/features/notifications/infrastructure/repositories/notification_repository_impl.dart';
import 'package:teraflex_mobile/firebase_options.dart';
import 'package:teraflex_mobile/utils/device_util.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

class NotificationsCubit extends Cubit<NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationRepositoryImpl notificationRepository =
      NotificationRepositoryImpl(datasource: TfxNotificationDatasource());

  NotificationsCubit() : super(const NotificationsState());

  static Future<void> initializeFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void statusChange() async {
    if (state.status == AuthorizationStatus.authorized) {
      _notificationStatusChanged(AuthorizationStatus.denied);
      return;
    }
    _notificationStatusChanged(AuthorizationStatus.authorized);
  }

  void _notificationStatusChanged(AuthorizationStatus newStatus) async {
    emit(state.copyWith(status: newStatus, globalStatus: StatusUtil.loading));
    if (newStatus != AuthorizationStatus.authorized) {
      emit(state.copyWith(globalStatus: StatusUtil.success));
      return;
    }

    final token = await _getFCMToken();
    final imei = await DeviceUtil.getImei();

    // Realiza petición para registrar el token
    if (token == null) {
      emit(state.copyWith(globalStatus: StatusUtil.success));
      return;
    }

    try {
      await notificationRepository.registerToken(token: token, device: imei);
    } finally {
      emit(state.copyWith(globalStatus: StatusUtil.success));
    }
  }

  void initialStatusNotification() async {
    //final settings = await messaging.getNotificationSettings();
    //_notificationStatusChanged(settings.authorizationStatus);
    _requestPermissions();
    _onForegroundMessage();
  }

  Future<String?> _getFCMToken() async {
    if (state.status != AuthorizationStatus.authorized) return null;
    return await messaging.getToken();
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

    _onPushNotificationReceived(newNotification);
  }

  void _onPushNotificationReceived(PushMessage newNotification) async {
    // TODO: Realizar petición para obtener las notificaciones
    loadNotifications();
  }

  void loadNotifications() async {
    print('Cargando notificaciones');
    emit(state.copyWith(globalStatus: StatusUtil.loading));
    try {
      final notifications = await notificationRepository.getNotifications();
      emit(state.copyWith(
        myNotifications: notifications,
        globalStatus: StatusUtil.success,
      ));
    } catch (e) {
      emit(state.copyWith(globalStatus: StatusUtil.error));
    }
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
  }

  _requestPermissions() async {
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
