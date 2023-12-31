import 'package:dio/dio.dart';
import 'package:teraflex_mobile/config/constants/environment.dart';
import 'package:teraflex_mobile/features/auth/domain/datasources/login_datasource.dart';
import 'package:teraflex_mobile/features/auth/domain/entities/login_token.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/mappers/login_mapper.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/models/tfx/tfx_login_model.dart';

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
      if (e.response?.statusCode == 401) {
        throw Exception('Credenciales incorrectas');
      }
    } catch (e) {
      throw Exception('Error desconocido');
    }

    final token = LoginTokenModel.fromJson(response.data);
    return LoginTokenMapper.fromTfx(token);
  }
}
