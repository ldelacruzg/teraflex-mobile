import 'package:teraflex_mobile/features/auth/domain/entities/login_token.dart';
import 'package:teraflex_mobile/features/auth/domain/entities/user/user.dart';

abstract class LoginDatasource {
  Future<LoginToken> login({
    required String dni,
    required String password,
  });

  Future<User> getProfile();
}
