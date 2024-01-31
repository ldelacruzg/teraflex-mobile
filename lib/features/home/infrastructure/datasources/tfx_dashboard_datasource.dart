import 'package:dio/dio.dart';
import 'package:teraflex_mobile/config/constants/dio_teraflex_api.dart';
import 'package:teraflex_mobile/features/home/domain/datasources/dashboard_datasource.dart';
import 'package:teraflex_mobile/features/home/domain/entities/global_summary.dart';
import 'package:teraflex_mobile/features/home/infrastructure/mappers/dashboard_mapper.dart';
import 'package:teraflex_mobile/features/home/infrastructure/models/tfx_global_summary_model.dart';

class TfxDashboardDatasource extends DashboardDatasource {
  @override
  Future<GlobalSummary> getGlobalSummary({required int patientId}) async {
    late Response<dynamic> response;
    final dio = await DioTeraflexAPI.dio;

    try {
      response = await dio.get('/patients/$patientId/global-summary');
    } catch (e) {
      throw Exception(e);
    }

    final data = TfxGlobalSummaryModel.fromJson(response.data);
    final globalSummary = DashboardMapper.toTfxGlobalSummary(data);

    return globalSummary;
  }
}
