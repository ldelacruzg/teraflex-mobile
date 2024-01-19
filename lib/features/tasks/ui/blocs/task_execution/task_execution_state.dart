part of 'task_execution_cubit.dart';

enum ExecutionStatus {
  running,
  finished,
  resting,
  initial,
}

enum TimerState {
  done,
  current,
  pending,
}

class Serie {
  final TimerState status;
  final List<Repetition> repetitions;

  Serie({
    this.status = TimerState.pending,
    required this.repetitions,
  });

  Serie copyWith({
    TimerState? status,
    List<Repetition>? repetitions,
  }) {
    return Serie(
      status: status ?? this.status,
      repetitions: repetitions ?? this.repetitions,
    );
  }

  @override
  String toString() {
    return "Serie { status: $status, repetitions: ${repetitions.map((elem) => elem.toString())} }";
  }
}

class Repetition {
  final TimerState status;

  Repetition({this.status = TimerState.pending});

  Repetition copyWith({TimerState? status}) {
    return Repetition(status: status ?? this.status);
  }

  @override
  String toString() {
    return "{ status: $status }";
  }
}

class TaskExecutionState extends Equatable {
  final TaskConfig? taskConfig;
  final int currentSeries;
  final int currentRepetition;
  final Duration repetitionDuration;
  final Duration restingDuration;
  final ExecutionStatus status;
  final List<Serie> executions;

  const TaskExecutionState({
    this.taskConfig,
    this.currentSeries = 0,
    this.currentRepetition = 0,
    this.repetitionDuration = const Duration(seconds: 0),
    this.restingDuration = const Duration(seconds: 0),
    this.status = ExecutionStatus.initial,
    this.executions = const [],
  });

  TaskExecutionState copyWith({
    TaskConfig? taskConfig,
    int? currentSeries,
    int? currentRepetition,
    Duration? repetitionDuration,
    Duration? restingDuration,
    ExecutionStatus? status,
    List<Serie>? executions,
  }) {
    return TaskExecutionState(
      taskConfig: taskConfig ?? this.taskConfig,
      currentSeries: currentSeries ?? this.currentSeries,
      currentRepetition: currentRepetition ?? this.currentRepetition,
      repetitionDuration: repetitionDuration ?? this.repetitionDuration,
      restingDuration: restingDuration ?? this.restingDuration,
      status: status ?? this.status,
      executions: executions ?? this.executions,
    );
  }

  List<Serie> changeStatusRepetition({
    int? serieIndex,
    int? repetitionIndex,
    required TimerState status,
  }) {
    final newExecutions = List<Serie>.from(executions);
    final repetitionIdx = repetitionIndex ?? currentRepetition - 1;

    final serie = newExecutions[serieIndex ?? currentSeries - 1];
    final repetition = serie.repetitions[repetitionIndex ?? repetitionIdx];

    serie.repetitions[repetitionIndex ?? repetitionIdx] =
        repetition.copyWith(status: status);

    return newExecutions;
  }

  List<Serie> changeStatusSerie({
    int? serieIndex,
    required TimerState status,
  }) {
    final newExecutions = List<Serie>.from(executions);
    final serieIdx = serieIndex ?? currentSeries - 1;

    final serie = newExecutions[serieIdx];

    newExecutions[serieIdx] = serie.copyWith(status: status);

    return newExecutions;
  }

  List<Serie> changeSerieAndRepetitionStatus({
    int? serieIndex,
    int? repetitionIndex,
    required TimerState status,
  }) {
    final newExecutions = List<Serie>.from(executions);
    final repetitionIdx = repetitionIndex ?? currentRepetition - 1;
    final serieIdx = serieIndex ?? currentSeries - 1;

    final serie = newExecutions[serieIdx];
    final repetition = serie.repetitions[repetitionIdx];

    newExecutions[serieIdx] = serie.copyWith(status: status);
    serie.repetitions[repetitionIdx] = repetition.copyWith(status: status);

    return newExecutions;
  }

  @override
  List<Object> get props => [
        currentSeries,
        currentRepetition,
        repetitionDuration,
        restingDuration,
        status,
        executions,
      ];
}
