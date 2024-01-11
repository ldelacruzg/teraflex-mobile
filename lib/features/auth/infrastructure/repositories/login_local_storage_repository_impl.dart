import 'package:teraflex_mobile/features/auth/domain/datasources/login_local_storage_datasource.dart';
import 'package:teraflex_mobile/features/auth/domain/entities/login_token.dart';
import 'package:teraflex_mobile/features/auth/domain/entities/user/user.dart';
import 'package:teraflex_mobile/features/auth/domain/repositories/login_local_storage_repository.dart';

class LoginLocalStorageRepositoryImpl extends LoginLocalStorageRepository {
  final LoginLocalStorageDatasource datasource;

  LoginLocalStorageRepositoryImpl({required this.datasource});

  @override
  Future<void> deleteToken() async {
    await datasource.deleteToken();
  }

  @override
  Future<LoginToken?> getToken() async {
    return await datasource.getToken();
  }

  @override
  Future<void> setToken(LoginToken token) async {
    await datasource.setToken(token);
  }

  @override
  Future<void> setUser(User user) {
    return datasource.setUser(user);
  }

  @override
  Future<bool> hasToken() {
    return datasource.hasToken();
  }

  @override
  Future<void> logout() {
    return datasource.logout();
  }

  @override
  Future<User?> getUser() {
    return datasource.getUser();
  }
}
