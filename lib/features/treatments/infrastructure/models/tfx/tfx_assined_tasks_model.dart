class TfxAssignedTasksModel {
  int statusCode;
  String message;
  List<AssignedTasksDataModel> data;

  TfxAssignedTasksModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory TfxAssignedTasksModel.fromJson(Map<String, dynamic> json) =>
      TfxAssignedTasksModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<AssignedTasksDataModel>.from(
            json["data"].map((x) => AssignedTasksDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AssignedTasksDataModel {
  AssinedTaskModel task;
  TaskConfigModel setting;

  AssignedTasksDataModel({
    required this.task,
    required this.setting,
  });

  factory AssignedTasksDataModel.fromJson(Map<String, dynamic> json) =>
      AssignedTasksDataModel(
        task: AssinedTaskModel.fromJson(json["task"]),
        setting: TaskConfigModel.fromJson(json["setting"]),
      );

  Map<String, dynamic> toJson() => {
        "task": task.toJson(),
        "setting": setting.toJson(),
      };
}

class TaskConfigModel {
  String timePerRepetition;
  int repetitions;
  String breakTime;
  int series;

  TaskConfigModel({
    required this.timePerRepetition,
    required this.repetitions,
    required this.breakTime,
    required this.series,
  });

  factory TaskConfigModel.fromJson(Map<String, dynamic> json) =>
      TaskConfigModel(
        timePerRepetition: json["timePerRepetition"],
        repetitions: json["repetitions"],
        breakTime: json["breakTime"],
        series: json["series"],
      );

  Map<String, dynamic> toJson() => {
        "timePerRepetition": timePerRepetition,
        "repetitions": repetitions,
        "breakTime": breakTime,
        "series": series,
      };
}

class AssinedTaskModel {
  int id;
  String title;
  String description;
  DateTime assignmentDate;
  DateTime? performanceDate;
  DateTime expirationDate;

  AssinedTaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.assignmentDate,
    required this.performanceDate,
    required this.expirationDate,
  });

  factory AssinedTaskModel.fromJson(Map<String, dynamic> json) =>
      AssinedTaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        assignmentDate: DateTime.parse(json["assignmentDate"]),
        performanceDate: json["performanceDate"] == null
            ? null
            : DateTime.parse(json["performanceDate"]),
        expirationDate: DateTime.parse(json["expirationDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "assignmentDate": assignmentDate.toIso8601String(),
        "performanceDate": performanceDate?.toIso8601String(),
        "expirationDate":
            "${expirationDate.year.toString().padLeft(4, '0')}-${expirationDate.month.toString().padLeft(2, '0')}-${expirationDate.day.toString().padLeft(2, '0')}",
      };
}
