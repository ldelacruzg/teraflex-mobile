import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/simple_treatment.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/assigned_tasks/assigned_tasks_cubit.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/simple_treatment_list/simple_treatment_list_cubit.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/treatment_detail/treatment_detail_cubit.dart';
import 'package:teraflex_mobile/shared/widgets/connection_issues.dart';
import 'package:teraflex_mobile/shared/widgets/span_info.dart';

class TreatmentView extends StatelessWidget {
  const TreatmentView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SimpleTreatmentListCubit>().state;

    if (state.status == Status.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == Status.error) {
      return const ConnectionIssues();
    }

    if (state.status == Status.notLogged) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('No hay usuario logueado')),
          FilledButton(
            onPressed: () => context.go('/'),
            child: const Text('Ir a login'),
          ),
        ],
      );
    }

    if (state.treatments.isEmpty) {
      return const Center(child: Text('No hay tratamientos'));
    }

    return ListView.builder(
      itemCount: state.treatments.length,
      itemBuilder: (context, index) {
        final treatment = state.treatments[index];
        return ListTreatmentItem(
          title: treatment.title,
          treatment: treatment,
        );
      },
    );
  }
}

class ListTreatmentItem extends StatelessWidget {
  final String title;
  final SimpleTreatment treatment;

  const ListTreatmentItem({
    super.key,
    required this.title,
    required this.treatment,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      title: Badge(
        isLabelVisible: treatment.pendingTasks > 0,
        backgroundColor: colorScheme.primary,
        label: Text('${treatment.pendingTasks}'),
        child: Text(
          treatment.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      subtitle: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        spacing: 4.0,
        runSpacing: 4.0,
        children: [
          SpanInfo(
            value: 'Completadas: ${treatment.completedTasks}',
            color: Colors.greenAccent,
          ),
          SpanInfo(
            value: 'Vencidas: ${treatment.overdueTasks}',
            color: Colors.redAccent,
          )
        ],
      ),
      leading: const CircleAvatar(child: Icon(Icons.fitness_center_rounded)),
      trailing: const Icon(Icons.arrow_forward_rounded),
      onTap: () {
        context.read<AssignedTasksCubit>().getTasks(treatmentId: treatment.id);

        context
            .read<TreatmentDetailCubit>()
            .getTreatment(treatmentId: treatment.id);

        context.push('/home/treatments/${treatment.id}');
      },
    );
  }
}
