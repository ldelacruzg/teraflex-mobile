class TfxCurrentWeekLeaderboard {
  int statusCode;
  String message;
  List<TfxLeaderboarRowModel> data;

  TfxCurrentWeekLeaderboard({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory TfxCurrentWeekLeaderboard.fromJson(Map<String, dynamic> json) =>
      TfxCurrentWeekLeaderboard(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<TfxLeaderboarRowModel>.from(
            json["data"].map((x) => TfxLeaderboarRowModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TfxLeaderboarRowModel {
  int patientId;
  String firstName;
  String lastName;
  int qtyTasks;
  int qtyTasksCompleted;
  double accuracy;

  TfxLeaderboarRowModel({
    required this.patientId,
    required this.firstName,
    required this.lastName,
    required this.qtyTasks,
    required this.qtyTasksCompleted,
    required this.accuracy,
  });

  factory TfxLeaderboarRowModel.fromJson(Map<String, dynamic> json) =>
      TfxLeaderboarRowModel(
        patientId: json["patientId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        qtyTasks: json["qtyTasks"],
        qtyTasksCompleted: json["qtyTasksCompleted"],
        accuracy: json["accuracy"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "patientId": patientId,
        "firstName": firstName,
        "lastName": lastName,
        "qtyTasks": qtyTasks,
        "qtyTasksCompleted": qtyTasksCompleted,
        "accuracy": accuracy,
      };
}
