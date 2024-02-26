class TfxRedeemProductModel {
  int statusCode;
  String message;
  TfxRedeemProductDataModel data;

  TfxRedeemProductModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory TfxRedeemProductModel.fromJson(Map<String, dynamic> json) =>
      TfxRedeemProductModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: TfxRedeemProductDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.toJson(),
      };
}

class TfxRedeemProductDataModel {
  String code;

  TfxRedeemProductDataModel({
    required this.code,
  });

  factory TfxRedeemProductDataModel.fromJson(Map<String, dynamic> json) =>
      TfxRedeemProductDataModel(
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
      };
}
