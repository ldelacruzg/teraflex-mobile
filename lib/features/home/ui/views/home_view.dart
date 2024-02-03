import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teraflex_mobile/features/home/ui/blocs/global_summary/global_summary_cubit.dart';
import 'package:teraflex_mobile/utils/date_util.dart';
import 'package:teraflex_mobile/utils/rank.enum.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  String get monthName {
    final monthNames = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];
    return monthNames[DateTime.now().month - 1];
  }

  double getProgressHistory(BuildContext context) {
    final state = context.watch<GlobalSummaryCubit>().state;
    return state.globalSummary.qtyTasksHistory > 0
        ? state.globalSummary.qtyTasksCompletedHistory /
            state.globalSummary.qtyTasksHistory
        : 0;
  }

  double getProgressWeekly(BuildContext context) {
    final state = context.watch<GlobalSummaryCubit>().state;
    return state.globalSummary.qtyTasksWeekly > 0
        ? state.globalSummary.qtyTasksCompletedWeekly /
            state.globalSummary.qtyTasksWeekly
        : 0;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GlobalSummaryCubit>().state;
    final today = DateTime.now();

    if (state.status == StatusUtil.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == StatusUtil.error) {
      return Center(
        child: Text(state.statusMessage ?? 'Error desconocido'),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$monthName, ${today.year}',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const HorizontalDays(),
            const SizedBox(height: 20),
            //const CustomCardResumen(),
            Row(
              children: [
                CardInfo(
                  icon: Icons.attach_money_rounded,
                  title: 'FLEXICOINS',
                  value: state.globalSummary.flexicoins,
                ),
                const Spacer(),
                CardInfo(
                  icon: Icons.star_rounded,
                  title: 'EXP',
                  value: state.globalSummary.experience,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CardInfo(
                  icon: Icons.history,
                  title: 'HISTORIAL',
                  isProgress: true,
                  valueProgress: getProgressHistory(context),
                ),
                const Spacer(),
                CardInfo(
                  icon: Icons.calendar_month_rounded,
                  title: 'SEMANAL',
                  isProgress: true,
                  valueProgress: getProgressWeekly(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CardRank(rank: state.globalSummary.rank),
          ],
        ),
      ),
    );
  }
}

class CardRank extends StatelessWidget {
  final Rank rank;

  const CardRank({
    super.key,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              //backgroundColor: Colors.white,
              child: Icon(
                Icons.fitness_center_rounded,
                size: 30,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              'RANGO ${rankToString(rank).toUpperCase()}',
              maxLines: 1,
              style: const TextStyle(
                //color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardInfo extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;
  final bool isProgress;
  final double valueProgress;

  const CardInfo({
    super.key,
    required this.title,
    this.value = 0,
    required this.icon,
    this.isProgress = false,
    this.valueProgress = 0,
  });

  String get valueProgressString => (valueProgress * 100).toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.45,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                //backgroundColor: Colors.white,
                child: Icon(
                  icon,
                  color: colorScheme.primary,
                  size: 40,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                isProgress ? '$valueProgressString %' : value.toString(),
                style: const TextStyle(
                  //color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  //color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Visibility(
                visible: isProgress,
                child: const SizedBox(height: 10),
              ),
              Visibility(
                visible: isProgress,
                child: LinearProgressIndicator(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  value: valueProgress,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalDays extends StatefulWidget {
  const HorizontalDays({super.key});

  @override
  State<HorizontalDays> createState() => _HorizontalDaysState();
}

class _HorizontalDaysState extends State<HorizontalDays> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollToCurrentDay();
    });
  }

  void scrollToCurrentDay() {
    double offset = DateTime.now().weekday * 100.0;
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(7, (index) {
          final thisWeek = DateUtil.thisWeek();
          return DayItem(date: thisWeek[index]);
        }),
      ),
    );
  }
}

class DayItem extends StatelessWidget {
  final DateTime date;

  const DayItem({
    super.key,
    required this.date,
  });

  String get dayName {
    final dayNames = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    return dayNames[date.weekday - 1];
  }

  String get dayNumber => date.day.toString().padLeft(2, '0');

  bool get isToday {
    final today = DateTime.now();
    return today.year == date.year &&
        today.month == date.month &&
        today.day == date.day;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 100,
      child: Card(
        color: isToday ? colorScheme.onPrimary : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              Text(
                dayNumber,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isToday ? colorScheme.primary : null,
                ),
              ),
              Text(
                dayName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isToday ? colorScheme.primary : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCardResumen extends StatelessWidget {
  const CustomCardResumen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 40,
      color: colorScheme.primary,
      child: const Padding(
        padding: EdgeInsets.only(
          top: 20,
          bottom: 25,
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumen',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VerticalSpan(
                  icon: Icons.star_rounded,
                  text: '10',
                ),
                VerticalSpan(
                  icon: Icons.task_rounded,
                  text: '1/5',
                ),
                VerticalSpan(
                  icon: Icons.monetization_on_rounded,
                  text: '5',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class VerticalSpan extends StatelessWidget {
  final IconData icon;
  final String text;

  const VerticalSpan({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          child: Icon(
            icon,
            color: colorScheme.primary,
            size: 32,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
