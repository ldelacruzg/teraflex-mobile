import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id? isarId;
  final int id;
  final String firstName;
  final String lastName;
  final String docNumber;
  final String phone;
  final String description;
  final bool status;
  final String birthDate;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.docNumber,
    required this.phone,
    required this.description,
    required this.status,
    required this.birthDate,
  });

  getObjetc() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'docNumber': docNumber,
      'phone': phone,
      'description': description,
      'status': status,
      'birthDate': birthDate,
    };
  }
}
