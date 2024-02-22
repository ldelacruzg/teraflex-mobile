part of 'notifications_cubit.dart';

class NotificationsState extends Equatable {
  final StatusUtil globalStatus;
  final AuthorizationStatus status;
  final List<PushMessage> notifications;
  final List<MyNotification> myNotifications;

  const NotificationsState({
    this.globalStatus = StatusUtil.initial,
    this.status = AuthorizationStatus.notDetermined,
    this.notifications = const [],
    this.myNotifications = const [],
  });

  NotificationsState copyWith({
    StatusUtil? globalStatus,
    AuthorizationStatus? status,
    List<PushMessage>? notifications,
    List<MyNotification>? myNotifications,
  }) {
    return NotificationsState(
      globalStatus: globalStatus ?? this.globalStatus,
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      myNotifications: myNotifications ?? this.myNotifications,
    );
  }

  @override
  List<Object> get props =>
      [globalStatus, status, notifications, myNotifications];
}
