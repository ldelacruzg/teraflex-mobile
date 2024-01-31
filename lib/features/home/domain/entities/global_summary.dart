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
}
