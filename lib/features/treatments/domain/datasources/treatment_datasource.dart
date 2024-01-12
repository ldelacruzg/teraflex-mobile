import 'package:teraflex_mobile/features/treatments/domain/entities/simple_treatment.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/treatment.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/treatment_task.dart';

abstract class TreatmentDatasource {
  Future<List<SimpleTreatment>> simpleTreatmentList({
    required int patientId,
    bool? treatmentActive,
  });

  Future<List<TreatmentTask>> getAssignedTasks({
    required int treatmentId,
    bool? taskDone,
  });

  Future<Treatment> getTreatment({
    required int treatmentId,
  });
}
