class PushMessage {
  final String messageId;
  final String title;
  final String body;
  final DateTime sendDate;
  final Map<String, dynamic>? data;

  PushMessage({
    required this.messageId,
    required this.title,
    required this.body,
    required this.sendDate,
    this.data,
  });
}
