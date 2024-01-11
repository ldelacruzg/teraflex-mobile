import 'package:dio/dio.dart';
import 'package:teraflex_mobile/config/constants/environment.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/datasources/isardb_login_local_storage_datasource.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/repositories/login_local_storage_repository_impl.dart';

class DioTeraflexAPI {
  static final String baseUrl = Environment.tfxApi;
  static const String contentType = 'application/json';

  static Future<Dio> get dio async {
    final repositoryLocalStorage = LoginLocalStorageRepositoryImpl(
      datasource: IsarDBLoginLocalStorageDatasource(),
    );

    final token = await repositoryLocalStorage.getToken();

    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        responseType: ResponseType.json,
        headers: {
          'Content-Type': contentType,
          'Authorization': 'Bearer ${token?.token}'
        },
      ),
    );
  }
}
