part of 'assigned_tasks_cubit.dart';

class AssignedTasksState extends Equatable {
  final List<TreatmentTask> tasks;
  final StatusUtil status;
  final String? statusMessage;
  final bool pendingTasks;
  final bool completedTasks;
  final bool expiredTasks;

  const AssignedTasksState({
    this.tasks = const [],
    this.status = StatusUtil.initial,
    this.statusMessage,
    this.pendingTasks = true,
    this.completedTasks = true,
    this.expiredTasks = true,
  });

  AssignedTasksState copyWith({
    List<TreatmentTask>? tasks,
    StatusUtil? status,
    String? statusMessage,
    bool? pendingTasks,
    bool? completedTasks,
    bool? expiredTasks,
  }) {
    return AssignedTasksState(
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
      pendingTasks: pendingTasks ?? this.pendingTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      expiredTasks: expiredTasks ?? this.expiredTasks,
    );
  }

  @override
  List<Object> get props => [
        tasks,
        status,
        pendingTasks,
        completedTasks,
        expiredTasks,
      ];
}
