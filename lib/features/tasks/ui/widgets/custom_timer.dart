import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/features/tasks/ui/blocs/task_execution/task_execution_cubit.dart';
import 'package:teraflex_mobile/shared/data/local_messages.dart';
import 'package:teraflex_mobile/shared/widgets/custom_confirm_dialog.dart';
import 'package:teraflex_mobile/utils/random_util.dart';

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
  late Timer? _timer;
  late Duration _start;
  Duration _countdown = const Duration(seconds: 5);
  bool _isRunning = false;
  bool _isCountdown = false;
  final player = AudioPlayer();
  final tts = FlutterTts();

  @override
  void initState() {
    _start = widget.duration;
    _timer = Timer(Duration.zero, () {});

    if (widget.autoStart) {
      _startTimer();
    }

    super.initState();
  }

  void _startTimer() {
    _isRunning = true;
    widget.onStart?.call();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_start.inSeconds == 0) {
        final nextStatus = context.read<TaskExecutionCubit>().state.nextStatus;

        if (nextStatus == ExecutionStatus.finished) {
          widget.onFinished?.call();
          return;
        }

        if (nextStatus == ExecutionStatus.resting) {
          widget.onFinished?.call();
        } else {
          final idxMessage = RandomUtil.getRandomIntBetween(
              0, nextRepetitionMessages.length - 1);
          _pauseTimer();
          _showConfirmDialogNextTimer();
          await tts.speak(nextRepetitionMessages[idxMessage]);
        }
      } else {
        setState(() {
          _start -= const Duration(seconds: 1);
        });
      }
    });
  }

  void _startCountdown() async {
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

    await player.play(AssetSource('sounds/start-task.mp3'));
    await tts.speak('Comenzamos en 5 segundos');
  }

  void _pauseTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
      _isRunning = false;
    }
  }

  void _resumeTimer() {
    if (_timer == null) {
      _start = widget.duration;
      _startTimer();
    }
  }

  void _showConfirmDialogNextTimer() {
    showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomConfirmDialog(
          title: '¿Estás listo para la siguiente repetición?',
          content: const Text(
              'Continua con la repetición cuando estés listo. Trata de mantener un ritmo constante y no te excedas.'),
          onConfirm: () => context.pop(true),
          textConfirm: 'Continuar',
        );
      },
    ).then((value) {
      if (value != null && value) {
        widget.onFinished?.call();
        _resumeTimer();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "${_countdown.inSeconds}",
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      }

      return IconButton.filled(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => CustomConfirmDialog(
              title: '¿Estás seguro de comenzar?',
              content: const Text(
                'Una vez iniciada la tarea no se puede detener. Tendrás una cuenta regresiva de 5 segundos.',
              ),
              onCancel: () => context.pop(),
              onConfirm: () {
                context.pop();
                _startCountdown();
              },
            ),
          );
          /* setState(() {
            _startCountdown();
          }); */
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
