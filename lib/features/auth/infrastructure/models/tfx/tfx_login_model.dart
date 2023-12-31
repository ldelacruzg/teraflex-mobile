class LoginTokenModel {
  int statusCode;
  String message;
  Data data;

  LoginTokenModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LoginTokenModel.fromJson(Map<String, dynamic> json) =>
      LoginTokenModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String token;
  String role;
  bool firstTime;

  Data({
    required this.token,
    required this.role,
    required this.firstTime,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        role: json["role"],
        firstTime: json["firstTime"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "role": role,
        "firstTime": firstTime,
      };
}
