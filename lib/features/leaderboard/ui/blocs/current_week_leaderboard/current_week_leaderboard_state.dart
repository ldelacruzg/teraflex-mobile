part of 'current_week_leaderboard_cubit.dart';

class CurrentWeekLeaderboardState extends Equatable {
  final List<LeaderboardRow> leaderboard;
  final StatusUtil status;
  final String? statusMessage;

  const CurrentWeekLeaderboardState({
    this.leaderboard = const [],
    this.status = StatusUtil.initial,
    this.statusMessage,
  });

  CurrentWeekLeaderboardState copyWith({
    List<LeaderboardRow>? leaderboard,
    StatusUtil? status,
    String? statusMessage,
  }) {
    return CurrentWeekLeaderboardState(
      leaderboard: leaderboard ?? this.leaderboard,
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object> get props => [leaderboard, status];
}
