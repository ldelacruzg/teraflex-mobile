import 'package:teraflex_mobile/utils/rank.enum.dart';

class GlobalSummary {
  final int flexicoins;
  final int experience;
  final Rank rank;
  final int qtyTasksCompletedHistory;
  final int qtyTasksWeekly;
  final int qtyTasksHistory;
  final int qtyTasksCompletedWeekly;

  const GlobalSummary({
    required this.flexicoins,
    required this.experience,
    required this.rank,
    required this.qtyTasksCompletedHistory,
    required this.qtyTasksWeekly,
    required this.qtyTasksHistory,
    required this.qtyTasksCompletedWeekly,
  });

  GlobalSummary copyWith({
    int? flexicoins,
    int? experience,
    Rank? rank,
    int? qtyTasksCompletedHistory,
    int? qtyTasksWeekly,
    int? qtyTasksHistory,
    int? qtyTasksCompletedWeekly,
  }) {
    return GlobalSummary(
      flexicoins: flexicoins ?? this.flexicoins,
      experience: experience ?? this.experience,
      rank: rank ?? this.rank,
      qtyTasksCompletedHistory:
          qtyTasksCompletedHistory ?? this.qtyTasksCompletedHistory,
      qtyTasksWeekly: qtyTasksWeekly ?? this.qtyTasksWeekly,
      qtyTasksHistory: qtyTasksHistory ?? this.qtyTasksHistory,
      qtyTasksCompletedWeekly:
          qtyTasksCompletedWeekly ?? this.qtyTasksCompletedWeekly,
    );
  }
}
