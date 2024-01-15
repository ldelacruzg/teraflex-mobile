import 'package:dio/dio.dart';
import 'package:teraflex_mobile/config/constants/dio_teraflex_api.dart';
import 'package:teraflex_mobile/features/tasks/domain/datasources/task_datasource.dart';
import 'package:teraflex_mobile/features/tasks/domain/entities/multimedia.dart';
import 'package:teraflex_mobile/features/tasks/infrastructure/mappers/multimedia_mapper.dart';
import 'package:teraflex_mobile/features/tasks/infrastructure/models/tfx/multimedia_model.dart';

class TfxTaskDatasource extends TaskDatasource {
  @override
  Future<List<Multimedia>> getVideos({required int assignmentId}) async {
    late Response<dynamic> response;
    final dio = await DioTeraflexAPI.dio;

    try {
      response = await dio.get('/assignments/$assignmentId/multimedia');
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('No autorizado');
      }
    } catch (e) {
      throw Exception('Error desconocido');
    }

    final data = TfxMultimediaModel.fromJson(response.data);
    final videos = MultimediaMapper.fromTfxMultimedia(data);

    return videos;
  }
}
