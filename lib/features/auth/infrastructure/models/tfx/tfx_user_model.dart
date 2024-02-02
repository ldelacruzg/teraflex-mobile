class TfxUserModel {
  int statusCode;
  String message;
  Data data;

  TfxUserModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory TfxUserModel.fromJson(Map<String, dynamic> json) => TfxUserModel(
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
  int id;
  String firstName;
  String lastName;
  String docNumber;
  String? phone;
  String? description;
  String? birthDate;
  String createdAt;
  String updatedAt;
  String role;
  dynamic categoryId;
  dynamic categoryName;
  bool status;

  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.docNumber,
    required this.phone,
    required this.description,
    required this.birthDate,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.categoryId,
    required this.categoryName,
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        docNumber: json["docNumber"],
        phone: json["phone"],
        description: json["description"],
        birthDate: json["birthDate"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        role: json["role"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "docNumber": docNumber,
        "phone": phone,
        "description": description,
        "birthDate": birthDate,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "role": role,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "status": status,
      };
}
