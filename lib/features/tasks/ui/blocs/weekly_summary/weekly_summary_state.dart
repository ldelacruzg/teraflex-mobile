part of 'weekly_summary_cubit.dart';

class WeeklySummaryState extends Equatable {
  final WeeklySummary weeklySummary;
  final StatusUtil status;
  final String? statusMessage;

  const WeeklySummaryState({
    this.weeklySummary = const WeeklySummary(
      completedTasks: 0,
      totalTasks: 0,
      totalExperience: 0,
      weeklyCompletedTasks: 0,
      weeklyExperience: 0,
      weeklyTasks: 0,
    ),
    this.status = StatusUtil.initial,
    this.statusMessage,
  });

  WeeklySummaryState copyWith({
    WeeklySummary? weeklySummary,
    StatusUtil? status,
    String? statusMessage,
  }) {
    return WeeklySummaryState(
      weeklySummary: weeklySummary ?? this.weeklySummary,
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object> get props => [weeklySummary, status];
}
