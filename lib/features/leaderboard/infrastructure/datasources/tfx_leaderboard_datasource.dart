import 'package:dio/dio.dart';
import 'package:teraflex_mobile/config/constants/dio_teraflex_api.dart';
import 'package:teraflex_mobile/features/leaderboard/domain/datasources/leaderboard_datasource.dart';
import 'package:teraflex_mobile/features/leaderboard/domain/entities/leaderboard_row.dart';
import 'package:teraflex_mobile/features/leaderboard/infrastructure/mappers/leaderboard_mapper.dart';
import 'package:teraflex_mobile/features/leaderboard/infrastructure/models/tfx/tfx_current_week_leaderboard_model.dart';

class TfxLeaderboardDatasource extends LeaderboardDatasource {
  @override
  Future<List<LeaderboardRow>> getCurrentWeekLeaderboard({
    required int patientId,
  }) async {
    late Response<dynamic> response;
    final dio = await DioTeraflexAPI.dio;

    try {
      response = await dio.get('/leaderboards/current', queryParameters: {
        'patientId': patientId,
      });
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw DioException(
          type: DioExceptionType.badResponse,
          requestOptions: e.requestOptions,
          message: e.message,
        );
      }
    } catch (e) {
      throw Exception('Error desconocido');
    }

    final data = TfxCurrentWeekLeaderboard.fromJson(response.data);
    final leaderboard = LeaderboardMapper.fromTfxCurrentWeekLeaderboard(data);

    return leaderboard;
  }
}
