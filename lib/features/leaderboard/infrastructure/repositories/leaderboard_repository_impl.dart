import 'package:teraflex_mobile/features/leaderboard/domain/datasources/leaderboard_datasource.dart';
import 'package:teraflex_mobile/features/leaderboard/domain/entities/leaderboard_row.dart';
import 'package:teraflex_mobile/features/leaderboard/domain/repositories/leaderboard_repository.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  final LeaderboardDatasource datasource;

  LeaderboardRepositoryImpl({required this.datasource});

  @override
  Future<List<LeaderboardRow>> getCurrentWeekLeaderboard({
    required int patientId,
  }) {
    return datasource.getCurrentWeekLeaderboard(patientId: patientId);
  }
}
