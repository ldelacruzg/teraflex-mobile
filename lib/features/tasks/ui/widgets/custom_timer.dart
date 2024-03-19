import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/shared/widgets/custom_confirm_dialog.dart';

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
