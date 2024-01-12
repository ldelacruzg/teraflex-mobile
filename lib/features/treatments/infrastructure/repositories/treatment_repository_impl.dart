import 'package:teraflex_mobile/features/treatments/domain/datasources/treatment_datasource.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/simple_treatment.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/treatment.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/treatment_task.dart';
import 'package:teraflex_mobile/features/treatments/domain/respositories/treatment_repository.dart';

class TreatmentRepositoryImpl extends TreatmentRepository {
  final TreatmentDatasource datasource;

  TreatmentRepositoryImpl({required this.datasource});

  @override
  Future<List<SimpleTreatment>> simpleTreatmentList(
      {required int patientId, bool? treatmentActive}) {
    return datasource.simpleTreatmentList(
        patientId: patientId, treatmentActive: treatmentActive);
  }

  @override
  Future<List<TreatmentTask>> getAssignedTasks(
      {required int treatmentId, bool? taskDone}) {
    return datasource.getAssignedTasks(
        treatmentId: treatmentId, taskDone: taskDone);
  }

  @override
  Future<Treatment> getTreatment({required int treatmentId}) {
    return datasource.getTreatment(treatmentId: treatmentId);
  }
}
