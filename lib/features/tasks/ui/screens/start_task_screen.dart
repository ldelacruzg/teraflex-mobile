import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:teraflex_mobile/shared/data/local_messages.dart';
import 'package:teraflex_mobile/utils/random_util.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:teraflex_mobile/features/tasks/ui/blocs/task_execution/task_execution_cubit.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/treatment_task.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/assigned_tasks/assigned_tasks_cubit.dart';
import 'package:teraflex_mobile/features//tasks/ui/widgets/custom_timer.dart';
import 'package:teraflex_mobile/shared/widgets/custom_confirm_dialog.dart';

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
    WakelockPlus.enable();
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
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
        return CustomConfirmDialog(
          title: '¿Desea salir de la tarea?',
          content:
              const Text('Si sale de la tarea, perderá el progreso actual.'),
          onCancel: () => context.pop(false),
          onConfirm: () => context.pop(true),
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
        assignmentId: widget.assignmentId,
      ),
    );
  }
}

class StartTaskView extends StatelessWidget {
  final TaskConfig taskConfig;
  final String taskTitle;
  final String assignmentId;
  final tts = FlutterTts();

  StartTaskView({
    super.key,
    required this.taskConfig,
    required this.taskTitle,
    required this.assignmentId,
  });

  void Function()? finishTask(BuildContext context, ExecutionStatus status) {
    if (status != ExecutionStatus.finished) return null;
    return () {
      _showConfirmDialog(context);
    };
  }

  void _showConfirmDialog(BuildContext context) {
    final idxMessage =
        RandomUtil.getRandomIntBetween(0, completionConfirmMessages.length - 1);

    final title = completionConfirmMessages[idxMessage];
    const message =
        'Ten en cuenta que esta tarea es fundamental para tu recuperación. Si no estás seguro de haber completado la tarea, te recomendamos que la finalices más tarde. ¿Estás seguro de que deseas finalizar la tarea?';

    tts.speak('$title. $message');
    showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomConfirmDialog(
          title: title,
          content: const Text(message),
          onCancel: () => context.pop(false),
          onConfirm: () => context.pop(true),
          textConfirm: "Si, finalizar",
          textCancel: "No",
        );
      },
    ).then((value) {
      // si finzaliza -> ir a la pantalla de finalización
      if (value != null && value) {
        context.go('/home/treatments/0/assignments/$assignmentId/finish');
      } else {
        // pausar el audio
        tts.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TaskExecutionCubit>().state;

    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                taskTitle,
                textAlign: TextAlign.center,
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
                onFinished: () {
                  context.read<TaskExecutionCubit>().nextTimer();
                },
                autoStart: state.currentSeries > 0,
              ),
            ),
            Visibility(
              visible: state.status == ExecutionStatus.resting,
              child: Column(
                children: [
                  const Text(
                    'Tiempo de descanso',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomTimer(
                    duration: state.restingDuration,
                    onFinished: context.read<TaskExecutionCubit>().nextTimer,
                    autoStart: state.status == ExecutionStatus.resting,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: state.status == ExecutionStatus.running,
              child: Text(
                'Serie ${state.currentSeries} - Repetición ${state.currentRepetition}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: state.executions.length,
                itemBuilder: (context, index) {
                  final serie = state.executions[index];
                  return TimerSerie(
                    status: serie.status,
                    parentSerie: index,
                    repetitions: serie.repetitions,
                    currentRepetition: state.currentRepetition,
                    currentSerie: state.currentSeries,
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
            onPressed: finishTask(context, state.status),
            child: const Text('FINALIZAR'),
          ),
        ),
      ],
    );
  }
}

class TimerSerie extends StatelessWidget {
  final TimerState status;
  final List<Repetition> repetitions;
  final int parentSerie;
  final int currentRepetition;
  final int currentSerie;

  const TimerSerie({
    super.key,
    required this.status,
    required this.repetitions,
    required this.parentSerie,
    required this.currentRepetition,
    required this.currentSerie,
  });

  String get strStatus {
    switch (status) {
      case TimerState.done:
        return 'Completada';
      case TimerState.current:
        return 'En Curso';
      case TimerState.pending:
        return 'Pendiente';
      default:
        return 'Pendiente';
    }
  }

  Color get colorStatus {
    switch (status) {
      case TimerState.done:
        return Colors.greenAccent.shade100;
      case TimerState.current:
        return Colors.blueAccent.shade100;
      case TimerState.pending:
        return Colors.orangeAccent.shade100;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      leading: const CircleAvatar(
        child: Icon(Icons.replay_outlined),
      ),
      title: Row(
        children: [
          Text(
            'Serie ${parentSerie + 1}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: colorStatus,
            ),
            child: Text(
              strStatus,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      children: [
        for (var i = 0; i < repetitions.length; i++)
          TimerRepeat(
            title: 'Repetición ${i + 1}',
            state: repetitions[i].status,
          ),
      ],
    );
  }
}

class TimerRepeat extends StatelessWidget {
  final String title;
  final TimerState state;

  const TimerRepeat({
    super.key,
    required this.title,
    required this.state,
  });

  IconData getIcon() {
    switch (state) {
      case TimerState.done:
        return Icons.check_circle_outline;
      case TimerState.current:
        return Icons.refresh_outlined;
      case TimerState.pending:
        return Icons.play_arrow_outlined;
      default:
        return Icons.play_arrow_outlined;
    }
  }

  Color? getColor() {
    return state == TimerState.pending ? Colors.grey : null;
  }

  Widget buildIcon() {
    if (state == TimerState.current) {
      return SpinPerfect(
        infinite: true,
        child: CircleAvatar(
          child: Icon(
            getIcon(),
            color: getColor(),
          ),
        ),
      );
    }

    return CircleAvatar(
      child: Icon(
        getIcon(),
        color: getColor(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: getColor()),
      ),
      trailing: CircleAvatar(
        child: buildIcon(),
      ),
    );
  }
}
