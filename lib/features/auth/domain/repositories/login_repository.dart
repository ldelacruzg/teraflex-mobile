import 'package:teraflex_mobile/features/auth/domain/entities/login_token.dart';

abstract class LoginRepository {
  Future<LoginToken> login({
    required String dni,
    required String password,
  });
}
