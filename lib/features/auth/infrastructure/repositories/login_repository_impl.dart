import 'package:teraflex_mobile/features/auth/domain/datasources/login_datasource.dart';
import 'package:teraflex_mobile/features/auth/domain/entities/login_token.dart';
import 'package:teraflex_mobile/features/auth/domain/entities/user/user.dart';
import 'package:teraflex_mobile/features/auth/domain/repositories/login_repository.dart';

class LoginRepositotyImpl extends LoginRepository {
  final LoginDatasource datasource;

  LoginRepositotyImpl({required this.datasource});

  @override
  Future<LoginToken> login({required String dni, required String password}) {
    return datasource.login(dni: dni, password: password);
  }

  @override
  Future<User> getProfile() {
    return datasource.getProfile();
  }

  @override
  Future<bool> changePassword(String newPassword) {
    return datasource.changePassword(newPassword);
  }
}
