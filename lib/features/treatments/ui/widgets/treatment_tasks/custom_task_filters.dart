import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/assigned_tasks/assigned_tasks_cubit.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/treatment_detail/treatment_detail_cubit.dart';

class CustomTaskFilters extends StatelessWidget {
  const CustomTaskFilters({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AssignedTasksCubit>().state;

    return AlertDialog(
      title: const Text('Filtrar tareas'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(),
            CustomSwitch(
              title: 'Pendientes',
              value: state.pendingTasks,
              onChanged: context.read<AssignedTasksCubit>().changePendingTasks,
            ),
            CustomSwitch(
              title: 'Completadas',
              value: state.completedTasks,
              onChanged:
                  context.read<AssignedTasksCubit>().changeCompletedTasks,
            ),
            CustomSwitch(
              title: 'Vencidas',
              value: state.expiredTasks,
              onChanged: context.read<AssignedTasksCubit>().changeExpiredTasks,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Cerrar'),
                ),
                TextButton(
                  onPressed: () {
                    context.pop();
                    final treatmentId = context
                        .read<TreatmentDetailCubit>()
                        .state
                        .treatment!
                        .id;

                    context
                        .read<AssignedTasksCubit>()
                        .getTasks(treatmentId: treatmentId);
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  final String title;
  final bool value;
  final void Function()? onChanged;

  const CustomSwitch({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Switch(
          value: value,
          onChanged: (value) => onChanged?.call(),
        ),
      ],
    );
  }
}
