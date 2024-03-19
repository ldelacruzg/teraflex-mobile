import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/treatment_task.dart';
import 'package:teraflex_mobile/utils/time_util.dart';

part 'task_execution_state.dart';

class TaskExecutionCubit extends Cubit<TaskExecutionState> {
  final player = AudioPlayer();
  final tts = FlutterTts();

  TaskExecutionCubit() : super(const TaskExecutionState());

  void init(TaskConfig taskConfig) {
    final List<Serie> executions = List.generate(taskConfig.series, (index) {
      return Serie(
        repetitions: List.generate(taskConfig.repetitions, (index) {
          return Repetition();
        }),
      );
    });

    emit(const TaskExecutionState().copyWith(
      taskConfig: taskConfig,
      repetitionDuration: TimeUtil.getDuration(taskConfig.timePerRepetition),
      restingDuration: TimeUtil.getDuration(taskConfig.breakTime),
      executions: executions,
    ));

    tts.setLanguage('es-ES');
    tts.setSpeechRate(0.5);
    tts.setVolume(1.0);
    tts.setPitch(1.0);
  }

  void start() {
    audioPlay('repetition');
    speak('Serie 1, Repetición 1');
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
      // finaliza la tarea
      audioPlay('end');
      speak('Tarea finalizada');
      return emit(state.copyWith(
        status: ExecutionStatus.finished,
        currentSeries: 0,
        currentRepetition: 0,
        executions: state.changeSerieAndRepetitionStatus(
          status: TimerState.done,
        ),
      ));
    }

    // 1. puede haber descanso entre series cuando haya MAS de una serie
    if (newRepetition > config.repetitions && // la serie esta completa
            config.series > 1 && // hay más de una serie
            config.breakTime > 0 && // hay descanso entre series
            state.status != ExecutionStatus.resting // no esta en descanso
        ) {
      audioPlay('break');
      speak('Tiempo de descanso');
      return emit(state.copyWith(
        status: ExecutionStatus.resting,
        executions: state.changeStatusRepetition(
          status: TimerState.done,
        ),
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
      // nueva serie
      audioPlay('repetition');
      speak('Serie $newSerie, Repetición 1');
      return emit(state.copyWith(
        currentSeries: newSerie,
        currentRepetition: 1,
        executions:
            state.changeSerieAndRepetitionStatus(status: TimerState.done),
      ));
    }

    // nueva repetición
    audioPlay('repetition');
    speak('Serie ${state.currentSeries}, Repetición $newRepetition');
    emit(state.copyWith(
      currentRepetition: newRepetition,
      executions: state.changeStatusRepetition(status: TimerState.done),
    ));
  }

  void audioPlay(String sound) async {
    await player.play(AssetSource('sounds/$sound-task.mp3'));
  }

  void speak(String text) async {
    await tts.speak(text);
  }
}
