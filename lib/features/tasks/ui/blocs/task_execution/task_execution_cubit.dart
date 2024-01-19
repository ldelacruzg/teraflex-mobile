import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/treatment_task.dart';
import 'package:teraflex_mobile/utils/time_util.dart';

part 'task_execution_state.dart';

class TaskExecutionCubit extends Cubit<TaskExecutionState> {
  TaskExecutionCubit() : super(const TaskExecutionState());

  void init(TaskConfig taskConfig) {
    emit(const TaskExecutionState().copyWith(
      taskConfig: taskConfig,
      repetitionDuration: TimeUtil.getDuration(taskConfig.timePerRepetition),
      restingDuration: TimeUtil.getDuration(taskConfig.breakTime),
    ));
  }

  void start() {
    emit(state.copyWith(
      status: ExecutionStatus.running,
      currentRepetition: 1,
      currentSeries: 1,
    ));
  }

  bool isTaskCompleted({required int series, required int repetitions}) {
    final config = state.taskConfig!;
    return series > config.series && repetitions > config.repetitions;
  }

  bool isSerieCompleted({required int repetitions}) {
    final config = state.taskConfig!;
    return repetitions > config.repetitions;
  }

  void nextTimer() {
    final config = state.taskConfig!;
    // aumentar la serie, repetición
    int newSerie = state.currentSeries + 1;
    int newRepetition = state.currentRepetition + 1;

    if (isTaskCompleted(series: newSerie, repetitions: newRepetition)) {
      return emit(const TaskExecutionState().copyWith(
        status: ExecutionStatus.finished,
      ));
    }

    // 1. puede haber descanso entre series cuando haya MAS de una serie
    if (newRepetition > config.repetitions && // la serie esta completa
            config.series > 1 && // hay más de una serie
            config.breakTime > 0 && // hay descanso entre series
            state.status != ExecutionStatus.resting // no esta en descanso
        ) {
      return emit(state.copyWith(
        status: ExecutionStatus.resting,
      ));
    }

    // 2. puede haber descanso entre repeticiones cuando haya una SOLA serie

    // cambia el stado a running si estaba en resting
    if (state.status == ExecutionStatus.resting) {
      emit(state.copyWith(
        status: ExecutionStatus.running,
      ));
    }

    // la repetición se reinicia cuando llega a su limite y hay más de una serie
    if (newRepetition > config.repetitions && config.series > 1) {
      return emit(state.copyWith(
        currentSeries: newSerie,
        currentRepetition: 1,
      ));
    }

    emit(state.copyWith(
      currentRepetition: newRepetition,
    ));
  }
}
