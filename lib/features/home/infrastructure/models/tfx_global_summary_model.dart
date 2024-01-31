class TfxGlobalSummaryModel {
  int statusCode;
  String message;
  TfxGlobalSummaryDataModel data;

  TfxGlobalSummaryModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory TfxGlobalSummaryModel.fromJson(Map<String, dynamic> json) =>
      TfxGlobalSummaryModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: TfxGlobalSummaryDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.toJson(),
      };
}

class TfxGlobalSummaryDataModel {
  int flexicoins;
  int experience;
  String rank;
  int qtyTasksHistory;
  int qtyTasksCompletedHistory;
  int qtyTasksWeekly;
  int qtyTasksCompletedWeekly;

  TfxGlobalSummaryDataModel({
    required this.flexicoins,
    required this.experience,
    required this.rank,
    required this.qtyTasksHistory,
    required this.qtyTasksCompletedHistory,
    required this.qtyTasksWeekly,
    required this.qtyTasksCompletedWeekly,
  });

  factory TfxGlobalSummaryDataModel.fromJson(Map<String, dynamic> json) =>
      TfxGlobalSummaryDataModel(
        flexicoins: json["flexicoins"],
        experience: json["experience"],
        rank: json["rank"],
        qtyTasksHistory: json["qtyTasksHistory"],
        qtyTasksCompletedHistory: json["qtyTasksCompletedHistory"],
        qtyTasksWeekly: json["qtyTasksWeekly"],
        qtyTasksCompletedWeekly: json["qtyTasksCompletedWeekly"],
      );

  Map<String, dynamic> toJson() => {
        "flexicoins": flexicoins,
        "experience": experience,
        "rank": rank,
        "qtyTasksHistory": qtyTasksHistory,
        "qtyTasksCompletedHistory": qtyTasksCompletedHistory,
        "qtyTasksWeekly": qtyTasksWeekly,
        "qtyTasksCompletedWeekly": qtyTasksCompletedWeekly,
      };
}
