import 'package:teraflex_mobile/features/treatments/domain/entities/simple_treatment.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/treatment_task.dart';
import 'package:teraflex_mobile/features/treatments/infrastructure/models/tfx/tfx_assined_tasks_model.dart';
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

  static List<TreatmentTask> fromTfxAssignedTasks(TfxAssignedTasksModel tasks) {
    return tasks.data.map((task) {
      return TreatmentTask(
        task: AssignedTask(
          id: task.task.id,
          title: task.task.title,
          description: task.task.description,
          assignmentDate: task.task.assignmentDate,
          performancedDate: task.task.performanceDate,
          expirationDate: task.task.expirationDate,
        ),
        setting: TaskConfig(
          timePerRepetition: double.parse(task.setting.timePerRepetition),
          repetitions: task.setting.repetitions,
          breakTime: double.parse(task.setting.breakTime),
          series: task.setting.series,
        ),
      );
    }).toList();
  }
}
