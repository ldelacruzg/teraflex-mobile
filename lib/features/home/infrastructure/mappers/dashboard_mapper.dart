import 'package:teraflex_mobile/features/home/domain/entities/global_summary.dart';
import 'package:teraflex_mobile/features/home/infrastructure/models/tfx_global_summary_model.dart';
import 'package:teraflex_mobile/utils/rank.enum.dart';

class DashboardMapper {
  static GlobalSummary toTfxGlobalSummary(TfxGlobalSummaryModel model) {
    return GlobalSummary(
      flexicoins: model.data.flexicoins,
      experience: model.data.experience,
      rank: rankFromString(model.data.rank),
      qtyTasksHistory: model.data.qtyTasksHistory,
      qtyTasksCompletedHistory: model.data.qtyTasksCompletedHistory,
      qtyTasksWeekly: model.data.qtyTasksWeekly,
      qtyTasksCompletedWeekly: model.data.qtyTasksCompletedWeekly,
    );
  }
}
