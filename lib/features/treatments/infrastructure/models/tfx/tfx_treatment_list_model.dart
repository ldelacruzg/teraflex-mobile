class TfxSimpleTreatmentListModel {
  int statusCode;
  String message;
  List<Data> data;

  TfxSimpleTreatmentListModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory TfxSimpleTreatmentListModel.fromJson(Map<String, dynamic> json) =>
      TfxSimpleTreatmentListModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  int id;
  String title;
  int numberTasks;
  int completedTasks;
  int overdueTasks;
  int pendingTasks;

  Data({
    required this.id,
    required this.title,
    required this.numberTasks,
    required this.completedTasks,
    required this.overdueTasks,
    required this.pendingTasks,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        numberTasks: json["numberTasks"],
        completedTasks: json["completedTasks"],
        overdueTasks: json["overdueTasks"],
        pendingTasks: json["pendingTasks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "numberTasks": numberTasks,
        "completedTasks": completedTasks,
        "overdueTasks": overdueTasks,
        "pendingTasks": pendingTasks,
      };
}
