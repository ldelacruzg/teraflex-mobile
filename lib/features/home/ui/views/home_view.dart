import 'package:flutter/material.dart';
import 'package:teraflex_mobile/utils/date_util.dart';

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

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

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
            const CustomCardResumen(),
            const SizedBox(height: 20),
            const Row(
              children: [
                CardInfo(
                  icon: Icons.star_rounded,
                  title: 'EXP',
                  value: '785',
                ),
                Spacer(),
                CardInfo(
                  icon: Icons.local_fire_department,
                  title: 'RACHA',
                  value: '20',
                ),
              ],
            ),
            const SizedBox(height: 20),
            const CardRank(),
          ],
        ),
      ),
    );
  }
}

class CardRank extends StatelessWidget {
  const CardRank({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      color: colorScheme.secondary,
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.fitness_center_rounded,
                size: 30,
                color: colorScheme.secondary,
              ),
            ),
            const SizedBox(width: 20),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RANGO RECUPERACIÓN',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  'POSICIÖN: 1',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CardInfo extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const CardInfo({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.45,
      child: Card(
        color: colorScheme.primary,
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(
                  icon,
                  color: colorScheme.primary,
                  size: 40,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalDays extends StatelessWidget {
  const HorizontalDays({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isToday ? colorScheme.secondary : Colors.white,
          border: Border.all(
            color: colorScheme.secondary,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              Text(
                dayNumber,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isToday ? Colors.white : null,
                ),
              ),
              Text(
                dayName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isToday ? Colors.white : null,
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
