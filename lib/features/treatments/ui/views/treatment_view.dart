import 'package:flutter/material.dart';

class TreatmentView extends StatefulWidget {
  const TreatmentView({super.key});

  @override
  State<TreatmentView> createState() => _TreatmentViewState();
}

class _TreatmentViewState extends State<TreatmentView> {
  @override
  void initState() {
    //context.read<SimpleTreatmentListCubit>().loadSimpleTreatments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* final state = context.watch<SimpleTreatmentListCubit>().state;

    if (state.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.treatments.isEmpty) {
      return const Center(child: Text('No hay tratamientos'));
    } */

    return ListView(
      children: [
        ListTile(
          title: const Text(
            'Tratamiento 1',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text('2/10'),
          leading:
              const CircleAvatar(child: Icon(Icons.fitness_center_rounded)),
          trailing: const Icon(Icons.arrow_forward_rounded),
          onTap: () {},
        ),
        ListTile(
          title: const Text(
            'Tratamiento 2',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text('5/10'),
          leading:
              const CircleAvatar(child: Icon(Icons.fitness_center_rounded)),
          trailing: const Icon(Icons.arrow_forward_rounded),
          onTap: () {},
        ),
      ],
    );
  }
}
