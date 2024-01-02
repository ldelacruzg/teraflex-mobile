import 'package:teraflex_mobile/features/auth/domain/entities/login_token.dart';
import 'package:teraflex_mobile/features/auth/domain/entities/user/user.dart';

abstract class LoginLocalStorageRepository {
  Future<void> setToken(LoginToken token);
  Future<LoginToken?> getToken();
  Future<void> deleteToken();
  Future<void> setUser(User user);
}
