import 'package:teraflex_mobile/features/treatments/domain/entities/simple_treatment.dart';

abstract class TreatmentRepository {
  Future<List<SimpleTreatment>> simpleTreatmentList({
    required int patientId,
    bool? treatmentActive,
  });
}
