class TfxWeeklySummaryModel {
  int statusCode;
  String message;
  TfxWeeklySummaryDataModel data;

  TfxWeeklySummaryModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory TfxWeeklySummaryModel.fromJson(Map<String, dynamic> json) =>
      TfxWeeklySummaryModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: TfxWeeklySummaryDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.toJson(),
      };
}

class TfxWeeklySummaryDataModel {
  int totalExperience;
  int weeklyExperience;
  int totalTasks;
  int completedTasks;
  int weeklyTasks;
  int weeklyCompletedTasks;

  TfxWeeklySummaryDataModel({
    required this.totalExperience,
    required this.weeklyExperience,
    required this.totalTasks,
    required this.completedTasks,
    required this.weeklyTasks,
    required this.weeklyCompletedTasks,
  });

  factory TfxWeeklySummaryDataModel.fromJson(Map<String, dynamic> json) =>
      TfxWeeklySummaryDataModel(
        totalExperience: json["totalExperience"],
        weeklyExperience: json["weeklyExperience"],
        totalTasks: json["totalTasks"],
        completedTasks: json["completedTasks"],
        weeklyTasks: json["weeklyTasks"],
        weeklyCompletedTasks: json["weeklyCompletedTasks"],
      );

  Map<String, dynamic> toJson() => {
        "totalExperience": totalExperience,
        "weeklyExperience": weeklyExperience,
        "totalTasks": totalTasks,
        "completedTasks": completedTasks,
        "weeklyTasks": weeklyTasks,
        "weeklyCompletedTasks": weeklyCompletedTasks,
      };
}
