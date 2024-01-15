class TfxMultimediaModel {
  int statusCode;
  String message;
  List<MultimediaDataModel> data;

  TfxMultimediaModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory TfxMultimediaModel.fromJson(Map<String, dynamic> json) =>
      TfxMultimediaModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<MultimediaDataModel>.from(
            json["data"].map((x) => MultimediaDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MultimediaDataModel {
  int id;
  String title;
  String description;
  String url;
  bool status;
  String type;
  String therapist;

  MultimediaDataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.status,
    required this.type,
    required this.therapist,
  });

  factory MultimediaDataModel.fromJson(Map<String, dynamic> json) =>
      MultimediaDataModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        status: json["status"],
        type: json["type"],
        therapist: json["therapist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "url": url,
        "status": status,
        "type": type,
        "therapist": therapist,
      };
}
