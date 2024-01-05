import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TreatmentTasksScreen extends StatelessWidget {
  static const String name = 'treatment_tasks_screen';
  final String treatmentId;

  const TreatmentTasksScreen({super.key, required this.treatmentId});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomTasksAppBar(),
      body: TreatmentTasksView(),
    );
  }
}

class TreatmentTasksView extends StatelessWidget {
  const TreatmentTasksView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [ListTaskItem()],
    );
  }
}

class ListTaskItem extends StatelessWidget {
  const ListTaskItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        'Equilibrio sobre una pierna',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: const CircleAvatar(
        child: Icon(Icons.fitness_center_rounded),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoItem(
                    icon: Icons.timer_outlined,
                    title: 'Tiempo',
                    value: '10 min',
                  ),
                  InfoItem(
                    icon: Icons.repeat_rounded,
                    title: 'Repeticiones',
                    value: '5',
                  ),
                  InfoItem(
                    icon: Icons.restart_alt_rounded,
                    title: 'Series',
                    value: 'NO',
                  ),
                  InfoItem(
                    icon: Icons.pause_rounded,
                    title: 'Descanso',
                    value: 'NO',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => context.push('/home/treatments/1/tasks/1'),
                    child: const Text('Ver tarea'),
                  ),
                  const SizedBox(width: 10),
                  FilledButton(
                    onPressed: () {},
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
      builder: (context) {
        return const CustomTreatmentBottomSheet();
      },
    );
  }

  void _onShowFilter(BuildContext context) {
    showDialog(
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

class CustomTaskFilters extends StatelessWidget {
  const CustomTaskFilters({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filtrar tareas'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Completadas'),
                Switch(
                  value: false,
                  onChanged: (value) => !value,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Vencidas'),
                Switch(
                  value: false,
                  onChanged: (value) => !value,
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Cerrar'),
                ),
                TextButton(
                  onPressed: () {},
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

class CustomTreatmentBottomSheet extends StatelessWidget {
  const CustomTreatmentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.5,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.blueAccent[50],
      ),
      child: const Padding(
        padding: EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InfoSpan(
                  icon: Icons.calendar_month_outlined,
                  title: 'Inicio',
                  value: '10/10/2021',
                ),
                InfoSpan(
                  icon: Icons.calendar_month_rounded,
                  title: 'Terminó',
                  value: 'Habilitado',
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Tratamiento',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Tratamiento para recuperar la movilidad de la mano',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Se le asignara multiples ejercicios dependiendo del tiempo de recuperación',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoSpan extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const InfoSpan({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 1,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  child: Icon(icon),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title),
                    Text(
                      value,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          child: Icon(icon),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Text(value),
      ],
    );
  }
}
