import 'package:teraflex_mobile/features/treatments/domain/entities/simple_treatment.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/treatment.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/treatment_task.dart';
import 'package:teraflex_mobile/features/treatments/infrastructure/models/tfx/tfx_assined_tasks_model.dart';
import 'package:teraflex_mobile/features/treatments/infrastructure/models/tfx/tfx_treatment_list_model.dart';
import 'package:teraflex_mobile/features/treatments/infrastructure/models/tfx/tfx_treatment_model.dart';

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

  static List<TreatmentTask> fromTfxAssignedTasks(TfxAssignedTasksModel tasks) {
    return tasks.data.map((assignment) {
      return TreatmentTask(
        id: assignment.assignmentId,
        task: AssignedTask(
          id: assignment.task.id,
          title: assignment.task.title,
          description: assignment.task.description,
          assignmentDate: assignment.task.assignmentDate,
          performancedDate: assignment.task.performanceDate,
          expirationDate: assignment.task.expirationDate,
        ),
        setting: TaskConfig(
          timePerRepetition: assignment.setting.timePerRepetition,
          repetitions: assignment.setting.repetitions,
          breakTime: assignment.setting.breakTime,
          series: assignment.setting.series,
        ),
      );
    }).toList();
  }

  static Treatment fromTfxTreatment(TfxTreatmentModel treatment) {
    return Treatment(
      id: treatment.data.id,
      title: treatment.data.title,
      description: treatment.data.description,
      startDate: treatment.data.startDate,
      endDate: treatment.data.endDate,
      isActive: treatment.data.isActive,
    );
  }
}
