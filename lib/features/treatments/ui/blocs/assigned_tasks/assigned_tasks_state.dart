part of 'assigned_tasks_cubit.dart';

class AssignedTasksState extends Equatable {
  final List<TreatmentTask> tasks;
  final StatusUtil status;
  final String? statusMessage;

  const AssignedTasksState({
    this.tasks = const [],
    this.status = StatusUtil.initial,
    this.statusMessage,
  });

  AssignedTasksState copyWith({
    List<TreatmentTask>? tasks,
    StatusUtil? status,
    String? statusMessage,
  }) {
    return AssignedTasksState(
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object> get props => [tasks, status];
}
