import 'package:teraflex_mobile/features/treatments/domain/entities/simple_treatment.dart';
import 'package:teraflex_mobile/features/treatments/infrastructure/models/tfx/tfx_treatment_list_model.dart';

class TreatmentMapper {
  static List<SimpleTreatment> fromTfxSimpleTreatment(
      TfxSimpleTreatmentListModel treatments) {
    return treatments.data.map((treatment) {
      return SimpleTreatment(
        id: treatment.id,
        title: treatment.title,
        numberTasks: treatment.numberTasks,
        completedTasks: treatment.completedTasks,
        pendingTasks: treatment.pendingTasks,
      );
    }).toList();
  }
}
