import 'package:dio/dio.dart';
import 'package:teraflex_mobile/config/constants/dio_teraflex_api.dart';
import 'package:teraflex_mobile/features/treatments/domain/datasources/treatment_datasource.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/simple_treatment.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/treatment.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/treatment_task.dart';
import 'package:teraflex_mobile/features/treatments/infrastructure/mappers/treatmet_mapper.dart';
import 'package:teraflex_mobile/features/treatments/infrastructure/models/tfx/tfx_assined_tasks_model.dart';
import 'package:teraflex_mobile/features/treatments/infrastructure/models/tfx/tfx_treatment_list_model.dart';
import 'package:teraflex_mobile/features/treatments/infrastructure/models/tfx/tfx_treatment_model.dart';

class TfxTreatmentDatasource extends TreatmentDatasource {
  @override
  Future<List<SimpleTreatment>> simpleTreatmentList(
      {required int patientId, bool? treatmentActive}) async {
    late Response<dynamic> response;
    final dio = await DioTeraflexAPI.dio;

    try {
      response = await dio.get('/treatments', queryParameters: {
        'patient-id': patientId,
        'treatment-active': treatmentActive,
        'tasks-number': true,
      });
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('No autorizado');
      }
    } catch (e) {
      throw Exception('Error desconocido');
    }

    final data = TfxSimpleTreatmentListModel.fromJson(response.data);
    final treatments = TreatmentMapper.fromTfxSimpleTreatment(data);

    return treatments;
  }

  @override
  Future<List<TreatmentTask>> getAssignedTasks({
    required int treatmentId,
    required bool completedTasks,
    required bool pendingTasks,
    required bool expiredTasks,
  }) async {
    late Response<dynamic> response;
    final dio = await DioTeraflexAPI.dio;
    final Map<String, dynamic> queryParameters = {
      'completedTasks': completedTasks,
      'pendingTasks': pendingTasks,
      'expiredTasks': expiredTasks,
    };

    try {
      response = await dio.get(
        '/treatments/$treatmentId/tasks',
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('No autorizado');
      }
    } catch (e) {
      throw Exception('Error desconocido');
    }

    final data = TfxAssignedTasksModel.fromJson(response.data);
    final tasks = TreatmentMapper.fromTfxAssignedTasks(data);

    return tasks;
  }

  @override
  Future<Treatment> getTreatment({required int treatmentId}) async {
    late Response<dynamic> response;
    final dio = await DioTeraflexAPI.dio;

    try {
      response = await dio.get('/treatments/$treatmentId');
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('No autorizado');
      }
    } catch (e) {
      throw Exception('Error desconocido');
    }

    final data = TfxTreatmentModel.fromJson(response.data);
    final treatment = TreatmentMapper.fromTfxTreatment(data);

    return treatment;
  }
}
