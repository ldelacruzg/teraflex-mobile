import 'package:teraflex_mobile/features/leaderboard/domain/entities/leaderboard_row.dart';
import 'package:teraflex_mobile/features/leaderboard/infrastructure/models/tfx/tfx_current_week_leaderboard_model.dart';

class LeaderboardMapper {
  static List<LeaderboardRow> fromTfxCurrentWeekLeaderboard(
      TfxCurrentWeekLeaderboard request) {
    return request.data
        .map((leaderboardRow) => LeaderboardRow(
              patientId: leaderboardRow.patientId,
              firstName: leaderboardRow.firstName,
              lastName: leaderboardRow.lastName,
              qtyTasks: leaderboardRow.qtyTasks,
              qtyTasksCompleted: leaderboardRow.qtyTasksCompleted,
              accuracy: leaderboardRow.accuracy,
            ))
        .toList();
  }
}
