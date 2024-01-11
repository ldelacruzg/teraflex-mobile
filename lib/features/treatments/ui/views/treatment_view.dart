import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/features/treatments/domain/entities/simple_treatment.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/simple_treatment_list/simple_treatment_list_cubit.dart';

class TreatmentView extends StatelessWidget {
  const TreatmentView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SimpleTreatmentListCubit>().state;

    if (state.status == Status.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == Status.error) {
      return Center(
        child: Text(state.statusMessage ?? 'Error al cargar los tratamientos'),
      );
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
    return ListTile(
      title: Text(
        treatment.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle:
          Text('Tareas: ${treatment.completedTasks}/${treatment.numberTasks}'),
      leading: const CircleAvatar(child: Icon(Icons.fitness_center_rounded)),
      trailing: const Icon(Icons.arrow_forward_rounded),
      onTap: () {
        context.push('/home/treatments/${treatment.id}');
      },
    );
  }
}
