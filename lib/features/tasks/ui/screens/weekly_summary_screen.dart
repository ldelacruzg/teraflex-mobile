import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/features/tasks/domain/entities/weekly_summary.dart';
import 'package:teraflex_mobile/features/tasks/ui/blocs/weekly_summary/weekly_summary_cubit.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/simple_treatment_list/simple_treatment_list_cubit.dart';
import 'package:teraflex_mobile/shared/data/local_messages.dart';
import 'package:teraflex_mobile/utils/random_util.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

class WeeklySummaryScreen extends StatefulWidget {
  static const String name = 'weekly-summary';
  final String assignmentId;

  const WeeklySummaryScreen({super.key, required this.assignmentId});

  @override
  State<WeeklySummaryScreen> createState() => _WeeklySummaryScreenState();
}

class _WeeklySummaryScreenState extends State<WeeklySummaryScreen> {
  final PageController pageController = PageController();
  late final String message;

  @override
  void initState() {
    super.initState();
    message = motivationalMessages[
        RandomUtil.getRandomIntBetween(0, motivationalMessages.length - 1)];

    context
        .read<WeeklySummaryCubit>()
        .finishAssignedTask(assignmentId: int.parse(widget.assignmentId));
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WeeklySummaryCubit>().state;

    if (state.status == StatusUtil.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state.status == StatusUtil.error) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(state.statusMessage ?? 'Error al cargar los datos'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: null,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // message
                      Column(
                        children: [
                          Text(
                            'Felicidades, ¡Buen trabajo!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Text(
                            message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      // image
                      Image.asset('assets/images/welcome_messages/3.png'),

                      // button
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () {
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: const Text('CONTINUAR'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                WeeklySummaryView(
                  weeklySummary: state.weeklySummary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WeeklySummaryView extends StatelessWidget {
  final WeeklySummary weeklySummary;

  const WeeklySummaryView({
    super.key,
    required this.weeklySummary,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Center(
                child: Text(
                  'Actualización de progreso',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CardInfoSummary(
                icon: Icons.star_border_purple500_rounded,
                title: 'Obtienes 15 EXP',
                total: weeklySummary.weeklyExperience,
                value: weeklySummary.totalExperience,
              ),
              const SizedBox(height: 20),
              CardInfoSummary(
                title: 'Tareas completadas',
                total: weeklySummary.totalTasks,
                value: weeklySummary.completedTasks,
                svg: 'trophy',
              ),
              const SizedBox(height: 20),
              CardInfoSummary(
                icon: Icons.date_range_rounded,
                title: 'Tareas de la semana',
                total: weeklySummary.weeklyTasks,
                value: weeklySummary.weeklyCompletedTasks,
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    context
                        .read<SimpleTreatmentListCubit>()
                        .loadSimpleTreatments();
                    context.go('/home');
                  },
                  child: const Text('CONTINUAR'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CardInfoSummary extends StatelessWidget {
  final IconData icon;
  final String title;
  final int total;
  final int value;
  final String? svg;

  const CardInfoSummary({
    super.key,
    this.icon = Icons.person_2_rounded,
    required this.title,
    required this.total,
    required this.value,
    this.svg,
  });

  double get percentage => (value / total).isNaN ? 0 : (value / total);

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: colorSchema.primary,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        leading: CircleAvatar(
          radius: 30,
          child: svg != null
              ? SvgPicture.asset(
                  'assets/icons/$svg.svg',
                  colorFilter: ColorFilter.mode(
                    colorSchema.primary,
                    BlendMode.srcIn,
                  ),
                  height: 40,
                )
              : Icon(
                  icon,
                  size: 40,
                  color: colorSchema.primary,
                ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: LinearProgressIndicator(
          value: percentage,
          minHeight: 15,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        trailing: Text(
          '$value/$total',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
