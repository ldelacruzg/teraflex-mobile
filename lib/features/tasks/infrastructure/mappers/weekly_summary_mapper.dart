import 'package:teraflex_mobile/features/tasks/domain/entities/weekly_summary.dart';
import 'package:teraflex_mobile/features/tasks/infrastructure/models/tfx/tfx_weekly_summary_model.dart';

class WeeklySummaryMapper {
  static WeeklySummary fromTfxWeeklySummary(TfxWeeklySummaryModel model) {
    return WeeklySummary(
      completedTasks: model.data.completedTasks,
      totalTasks: model.data.totalTasks,
      totalExperience: model.data.totalExperience,
      weeklyCompletedTasks: model.data.weeklyCompletedTasks,
      weeklyExperience: model.data.weeklyExperience,
      weeklyTasks: model.data.weeklyTasks,
    );
  }
}
