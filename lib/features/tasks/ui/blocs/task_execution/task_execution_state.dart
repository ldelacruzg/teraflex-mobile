part of 'task_execution_cubit.dart';

enum ExecutionStatus {
  running,
  finished,
  resting,
  initial,
}

class TaskExecutionState extends Equatable {
  final TaskConfig? taskConfig;
  final int currentSeries;
  final int currentRepetition;
  final Duration repetitionDuration;
  final Duration restingDuration;
  final ExecutionStatus status;

  const TaskExecutionState({
    this.taskConfig,
    this.currentSeries = 0,
    this.currentRepetition = 0,
    this.repetitionDuration = const Duration(seconds: 0),
    this.restingDuration = const Duration(seconds: 0),
    this.status = ExecutionStatus.initial,
  });

  TaskExecutionState copyWith({
    TaskConfig? taskConfig,
    int? currentSeries,
    int? currentRepetition,
    Duration? repetitionDuration,
    Duration? restingDuration,
    ExecutionStatus? status,
  }) {
    return TaskExecutionState(
      taskConfig: taskConfig ?? this.taskConfig,
      currentSeries: currentSeries ?? this.currentSeries,
      currentRepetition: currentRepetition ?? this.currentRepetition,
      repetitionDuration: repetitionDuration ?? this.repetitionDuration,
      restingDuration: restingDuration ?? this.restingDuration,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        currentSeries,
        currentRepetition,
        repetitionDuration,
        restingDuration,
        status,
      ];
}
