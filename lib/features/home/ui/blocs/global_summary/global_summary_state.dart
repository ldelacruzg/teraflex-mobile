part of 'global_summary_cubit.dart';

class GlobalSummaryState extends Equatable {
  final GlobalSummary globalSummary;
  final StatusUtil status;
  final String? statusMessage;

  const GlobalSummaryState({
    this.globalSummary = const GlobalSummary(
      flexicoins: 0,
      experience: 0,
      rank: Rank.fortaleza,
      qtyTasksHistory: 0,
      qtyTasksCompletedHistory: 0,
      qtyTasksWeekly: 0,
      qtyTasksCompletedWeekly: 0,
    ),
    this.status = StatusUtil.initial,
    this.statusMessage,
  });

  GlobalSummaryState copyWith({
    GlobalSummary? globalSummary,
    StatusUtil? status,
    String? statusMessage,
  }) {
    return GlobalSummaryState(
      globalSummary: globalSummary ?? this.globalSummary,
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object> get props => [globalSummary, status];
}
