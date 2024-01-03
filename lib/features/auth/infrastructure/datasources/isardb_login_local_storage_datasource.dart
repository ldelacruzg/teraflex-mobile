import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

import 'package:teraflex_mobile/features/auth/domain/datasources/login_local_storage_datasource.dart';
import 'package:teraflex_mobile/features/auth/domain/entities/login_token.dart';
import 'package:teraflex_mobile/features/auth/domain/entities/user/user.dart';

class IsarDBLoginLocalStorageDatasource extends LoginLocalStorageDatasource {
  late Future<Isar> _db;

  IsarDBLoginLocalStorageDatasource() {
    _db = _openDB();
  }

  Future<Isar> _openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [LoginTokenSchema, UserSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<void> deleteToken() async {
    final isar = await _db;
    await isar.writeTxn(() => isar.loginTokens.clear());
  }

  @override
  Future<LoginToken?> getToken() async {
    final isar = await _db;
    return await isar.loginTokens.get(1);
  }

  @override
  Future<void> setToken(LoginToken token) async {
    final isar = await _db;
    isar.writeTxnSync(() => isar.loginTokens.clearSync());
    isar.writeTxnSync(() => isar.loginTokens.putSync(token));
  }

  @override
  Future<void> setUser(User user) async {
    final isar = await _db;
    await isar.writeTxn(() => isar.users.clear());
    await isar.writeTxn(() => isar.users.put(user));
  }

  @override
  Future<bool> hasToken() async {
    final isar = await _db;
    return await isar.loginTokens.get(1) != null;
  }

  @override
  Future<void> logout() async {
    final isar = await _db;
    await Future.wait([
      isar.writeTxn(() => isar.loginTokens.clear()),
      isar.writeTxn(() => isar.users.clear()),
    ]);
  }
}
