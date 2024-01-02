import 'dart:async';

import 'package:dio/dio.dart';
import 'package:teraflex_mobile/config/constants/environment.dart';
import 'package:teraflex_mobile/features/auth/domain/datasources/login_datasource.dart';
import 'package:teraflex_mobile/features/auth/domain/entities/login_token.dart';
import 'package:teraflex_mobile/features/auth/domain/entities/user/user.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/datasources/isardb_login_local_storage_datasource.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/mappers/login_mapper.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/mappers/user_mapper.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/models/tfx/tfx_login_model.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/models/tfx/tfx_user_model.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/repositories/login_local_storage_repository_impl.dart';

class TfxLoginDatasource extends LoginDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.tfxApi,
      responseType: ResponseType.json,
    ),
  );

  @override
  Future<LoginToken> login({
    required String dni,
    required String password,
  }) async {
    final options = Options(
      headers: {
        'identification': dni,
        'password': password,
      },
    );

    late Response<dynamic> response;

    try {
      response = await dio.post('/auth/login', options: options);
    } on DioException catch (e) {
      if (e.response == null) {
        throw Exception('Error de conexión');
      }

      if (e.response?.statusCode == 401) {
        throw Exception('Credenciales incorrectas');
      }
    } catch (e) {
      throw Exception('Error desconocido');
    }

    final token = LoginTokenModel.fromJson(response.data);
    return LoginTokenMapper.fromTfx(token);
  }

  @override
  Future<User> getProfile() async {
    // obtener el token del storage
    final repository = LoginLocalStorageRepositoryImpl(
      datasource: IsarDBLoginLocalStorageDatasource(),
    );

    final token = await repository.getToken();

    final options = Options(
      headers: {
        'Authorization': 'Bearer ${token?.token}',
      },
    );

    late Response<dynamic> response;

    try {
      response = await dio.get('/user/my-profile', options: options);
    } catch (e) {
      throw Exception('Error desconocido');
    }

    final tfxUser = TfxUserModel.fromJson(response.data);
    return UserMapper.fromTfxUser(tfxUser);
  }
}
