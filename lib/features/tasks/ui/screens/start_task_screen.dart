import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/features/tasks/ui/blocs/task_execution/task_execution_cubit.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/treatment_task.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/assigned_tasks/assigned_tasks_cubit.dart';

class StartTaskScreen extends StatefulWidget {
  static const String name = 'start_task_screen';
  final String assignmentId;

  const StartTaskScreen({
    super.key,
    required this.assignmentId,
  });

  @override
  State<StartTaskScreen> createState() => _StartTaskScreenState();
}

class _StartTaskScreenState extends State<StartTaskScreen> {
  late TaskConfig taskConfig;
  late String taskTitle;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() {
    final assignmentTask = context
        .read<AssignedTasksCubit>()
        .getAssignedTask(assigmentId: int.parse(widget.assignmentId));

    context.read<TaskExecutionCubit>().init(assignmentTask.setting);

    taskConfig = assignmentTask.setting;
    taskTitle = assignmentTask.task.title;
  }

  void _onShowDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('¿Desea salir de la tarea?'),
          content:
              const Text('Si sale de la tarea, perderá el progreso actual.'),
          actions: [
            TextButton(
              onPressed: () => context.pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => context.pop(true),
              child: const Text('Salir'),
            ),
          ],
        );
      },
    ).then((value) => value ? context.pop() : null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _onShowDialog(context),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: StartTaskView(
        taskConfig: taskConfig,
        taskTitle: taskTitle,
      ),
    );
  }
}

class StartTaskView extends StatelessWidget {
  final TaskConfig taskConfig;
  final String taskTitle;

  const StartTaskView({
    super.key,
    required this.taskConfig,
    required this.taskTitle,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TaskExecutionCubit>().state;

    return Stack(
      children: [
        Column(
          children: [
            Center(
              child: Text(
                taskTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: state.status != ExecutionStatus.finished &&
                  state.status != ExecutionStatus.resting,
              child: CustomTimer(
                duration: state.repetitionDuration,
                onStart: state.status == ExecutionStatus.initial
                    ? context.read<TaskExecutionCubit>().start
                    : null,
                onFinished: context.read<TaskExecutionCubit>().nextTimer,
                autoStart: state.currentSeries > 0,
              ),
            ),
            Visibility(
              visible: state.status == ExecutionStatus.finished,
              child: const Text('La tarea ha finalizado'),
            ),
            Visibility(
              visible: state.status == ExecutionStatus.resting,
              child: Column(
                children: [
                  const Text('Tiempo de descanso'),
                  CustomTimer(
                    duration: state.restingDuration,
                    onFinished: context.read<TaskExecutionCubit>().nextTimer,
                    autoStart: state.status == ExecutionStatus.resting,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Serie ${state.currentSeries}, Repetición ${state.currentRepetition}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: taskConfig.series,
                itemBuilder: (context, index) {
                  return TimerSerie(
                    title: 'Serie ${index + 1}',
                    repetions: taskConfig.repetitions,
                  );
                },
              ),
            ),
            const SizedBox(height: 100)
          ],
        ),
        Positioned(
          left: 16,
          bottom: 20,
          right: 16,
          child: FilledButton(
            onPressed: () {},
            child: const Text('FINALIZAR'),
          ),
        ),
      ],
    );
  }
}

class TimerSerie extends StatelessWidget {
  final String title;
  final int repetions;

  const TimerSerie({
    super.key,
    required this.title,
    required this.repetions,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const CircleAvatar(
        child: Icon(Icons.replay_outlined),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: [
        for (var i = 0; i < repetions; i++)
          TimerRepeat(
            title: 'Repeticion ${i + 1}',
            state: TimerRepeatState.done,
          ),
      ],
    );
  }
}

enum TimerRepeatState {
  done,
  current,
  pending,
}

class TimerRepeat extends StatelessWidget {
  final String title;
  final TimerRepeatState state;

  const TimerRepeat({
    super.key,
    required this.title,
    required this.state,
  });

  IconData getIcon() {
    switch (state) {
      case TimerRepeatState.done:
        return Icons.check_circle_outline;
      case TimerRepeatState.current:
        return Icons.refresh_outlined;
      case TimerRepeatState.pending:
        return Icons.play_arrow_outlined;
      default:
        return Icons.play_arrow_outlined;
    }
  }

  Color? getColor() {
    return state == TimerRepeatState.pending ? Colors.grey : null;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: getColor()),
      ),
      trailing: CircleAvatar(
        child: Icon(
          getIcon(),
          color: getColor(),
        ),
      ),
    );
  }
}

class CustomTimer extends StatefulWidget {
  final Duration duration;
  final void Function()? onStart;
  final void Function()? onFinished;
  final bool autoStart;

  const CustomTimer({
    super.key,
    required this.duration,
    this.onStart,
    this.onFinished,
    this.autoStart = true,
  });

  @override
  State<CustomTimer> createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  late Timer _timer;
  late Duration _start;
  Duration _countdown = const Duration(seconds: 5);
  bool _isRunning = false;
  bool _isCountdown = false;

  @override
  void initState() {
    _start = widget.duration;

    if (widget.autoStart) {
      _startTimer();
    }

    super.initState();
  }

  void _startTimer() {
    _isRunning = true;
    widget.onStart?.call();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start.inSeconds == 0) {
        setState(() {
          _start = widget.duration;
        });
        widget.onFinished?.call();
      } else {
        setState(() {
          _start -= const Duration(seconds: 1);
        });
      }
    });
  }

  void _startCountdown() {
    _isCountdown = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown.inSeconds == 0) {
        setState(() {
          timer.cancel();
        });
        _startTimer();
      } else {
        setState(() {
          _countdown -= const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isRunning) {
      if (_isCountdown) {
        return Column(
          children: [
            const Text(
              'Comenzamos en',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "${_countdown.inSeconds}",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      }

      return IconButton.filled(
        onPressed: () {
          setState(() {
            _startCountdown();
          });
        },
        icon: const Icon(Icons.play_arrow_rounded, size: 40),
      );
    }

    return Text(
      "${_start.inMinutes}:${(_start.inSeconds % 60).toString().padLeft(2, '0')}",
      style: const TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
