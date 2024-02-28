import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/treatment_task.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/assigned_tasks/assigned_tasks_cubit.dart';
import 'package:teraflex_mobile/features/treatments/ui/widgets/treatment_tasks/custom_task_filters.dart';
import 'package:teraflex_mobile/features/treatments/ui/widgets/treatment_tasks/custom_treatment_bottom_sheet.dart';
import 'package:teraflex_mobile/features/treatments/ui/widgets/treatment_tasks/info_item.dart';
import 'package:teraflex_mobile/utils/date_util.dart';
import 'package:teraflex_mobile/utils/status_util.dart';
import 'package:teraflex_mobile/utils/time_util.dart';

class TreatmentTasksScreen extends StatelessWidget {
  static const String name = 'treatment_tasks_screen';
  final String treatmentId;

  const TreatmentTasksScreen({super.key, required this.treatmentId});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AssignedTasksCubit>().state;

    if (state.status == StatusUtil.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state.status == StatusUtil.error) {
      return Scaffold(
        appBar: const CustomTasksAppBar(),
        body: Column(
          children: [
            Center(
              child: Text(state.statusMessage ?? 'Error desconocido'),
            ),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Regresar'),
            ),
          ],
        ),
      );
    }

    if (state.status == StatusUtil.empty) {
      return Scaffold(
        appBar: const CustomTasksAppBar(),
        body: Center(
          child: Text(state.statusMessage ?? 'No hay tareas asignadas'),
        ),
      );
    }

    return TreatmentTasksView(tasks: state.tasks);
  }
}

class TreatmentTasksView extends StatelessWidget {
  final List<TreatmentTask> tasks;

  const TreatmentTasksView({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomTasksAppBar(),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTaskItem(assignment: task);
        },
      ),
    );
  }
}

class ListTaskItem extends StatelessWidget {
  final TreatmentTask assignment;

  const ListTaskItem({
    super.key,
    required this.assignment,
  });

  String get status {
    if (assignment.task.performancedDate != null) {
      return 'Completada el ${DateUtil.getShortDate(assignment.task.performancedDate!)}';
    }

    final now = DateTime.now();
    if (assignment.task.expirationDate
        .isBefore(DateTime(now.year, now.month, now.day))) {
      return 'Vencida el ${DateUtil.getShortDate(assignment.task.expirationDate)}';
    }

    return 'Pendiente hasta el ${DateUtil.getShortDate(assignment.task.expirationDate)}';
  }

  bool get enabled {
    final now = DateTime.now();
    final currentDate = DateTime(now.year, now.month, now.day);
    return assignment.task.performancedDate == null &&
        (currentDate.isBefore(assignment.task.expirationDate) ||
            currentDate.isAtSameMomentAs(assignment.task.expirationDate));
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        assignment.task.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(status),
      leading: const CircleAvatar(
        child: Icon(Icons.fitness_center_rounded),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.values[4],
                children: [
                  InfoItem(
                    icon: Icons.timer_outlined,
                    title: 'Tiempo',
                    value:
                        TimeUtil.getTime(assignment.setting.timePerRepetition),
                  ),
                  InfoItem(
                    icon: Icons.repeat_rounded,
                    title: 'Repetición',
                    value: assignment.setting.repetitions.toString(),
                  ),
                  InfoItem(
                    icon: Icons.restart_alt_rounded,
                    title: 'Series',
                    value: assignment.setting.series.toString(),
                  ),
                  InfoItem(
                    icon: Icons.pause_rounded,
                    title: 'Descanso',
                    value: TimeUtil.getTime(assignment.setting.breakTime),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => context
                        .push('/home/treatments/1/tasks/${assignment.id}'),
                    child: const Text('Ver tarea'),
                  ),
                  const SizedBox(width: 10),
                  FilledButton(
                    // /home/treatments/1/assignments/1/start
                    onPressed: enabled
                        ? () => context.push(
                            '/home/treatments/1/assignments/${assignment.id}/start')
                        : null,
                    child: const Text('Iniciar tarea'),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class CustomTasksAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTasksAppBar({
    super.key,
  });

  void _onShowInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const CustomTreatmentBottomSheet();
      },
    );
  }

  void _onShowFilter(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const CustomTaskFilters();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Tareas'),
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () => _onShowInfo(context),
        ),
        IconButton(
          icon: const Icon(Icons.tune_rounded),
          onPressed: () => _onShowFilter(context),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
