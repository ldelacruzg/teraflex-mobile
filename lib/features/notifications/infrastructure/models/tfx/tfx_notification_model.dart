class TfxNotificationModel {
  int statusCode;
  String message;
  List<TfxNotificationDataModel> data;

  TfxNotificationModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory TfxNotificationModel.fromJson(Map<String, dynamic> json) =>
      TfxNotificationModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<TfxNotificationDataModel>.from(
            json["data"].map((x) => TfxNotificationDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TfxNotificationDataModel {
  int id;
  String title;
  String body;
  int userId;
  String createdAt;
  String updatedAt;
  bool status;

  TfxNotificationDataModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory TfxNotificationDataModel.fromJson(Map<String, dynamic> json) =>
      TfxNotificationDataModel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        userId: json["userId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "userId": userId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "status": status,
      };
}
