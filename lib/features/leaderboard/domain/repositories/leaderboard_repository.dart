import 'package:teraflex_mobile/features/leaderboard/domain/entities/leaderboard_row.dart';

abstract class LeaderboardRepository {
  Future<List<LeaderboardRow>> getCurrentWeekLeaderboard({
    required int patientId,
  });
}
