import 'package:isar/isar.dart';

part 'login_token.g.dart';

@collection
class LoginToken {
  Id? isarId;
  final String token;
  final String role;
  final bool firstTime;

  LoginToken({
    required this.token,
    required this.role,
    required this.firstTime,
  });

  getString() {
    return {
      'token': token,
      'role': role,
      'firstTime': firstTime,
    };
  }
}
