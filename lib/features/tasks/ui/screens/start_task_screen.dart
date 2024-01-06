import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartTaskScreen extends StatelessWidget {
  static const String name = 'start_task_screen';
  final String taskId;

  const StartTaskScreen({
    super.key,
    required this.taskId,
  });

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
      body: const StartTaskView(),
    );
  }
}

class StartTaskView extends StatelessWidget {
  const StartTaskView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const Center(
              child: Text(
                'Estiramiento de Isquiotibiales',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '00:12',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: const [
                  TimerSerie(title: 'Serie 1'),
                  TimerSerie(title: 'Serie 2'),
                  TimerSerie(title: 'Serie 3'),
                ],
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

  const TimerSerie({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const CircleAvatar(
        child: Icon(Icons.replay_outlined),
      ),
      title: Text(title),
      children: const [
        TimerRepeat(
          title: 'Repetición 1',
          state: TimerRepeatState.done,
        ),
        TimerRepeat(
          title: 'Repetición 2',
          state: TimerRepeatState.current,
        ),
        TimerRepeat(
          title: 'Repetición 3',
          state: TimerRepeatState.pending,
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
