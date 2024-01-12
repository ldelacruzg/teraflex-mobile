class TfxTreatmentModel {
  int statusCode;
  String message;
  TfxTreatmentDataModel data;

  TfxTreatmentModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory TfxTreatmentModel.fromJson(Map<String, dynamic> json) =>
      TfxTreatmentModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: TfxTreatmentDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.toJson(),
      };
}

class TfxTreatmentDataModel {
  int id;
  String title;
  String description;
  bool isActive;
  DateTime startDate;
  dynamic endDate;
  int patientId;
  int therapistId;
  String createdAt;
  String updatedAt;

  TfxTreatmentDataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isActive,
    required this.startDate,
    required this.endDate,
    required this.patientId,
    required this.therapistId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TfxTreatmentDataModel.fromJson(Map<String, dynamic> json) =>
      TfxTreatmentDataModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isActive: json["isActive"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: json["endDate"],
        patientId: json["patientId"],
        therapistId: json["therapistId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "isActive": isActive,
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate": endDate,
        "patientId": patientId,
        "therapistId": therapistId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
