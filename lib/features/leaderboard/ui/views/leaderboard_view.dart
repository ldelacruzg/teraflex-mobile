import 'package:flutter/material.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => LeaderboardItem(
        name: 'User $index',
        position: index + 1,
        exp: index + 1 * 100,
      ),
    );
  }
}

class LeaderboardItem extends StatelessWidget {
  final String name;
  final int position;
  final int exp;

  const LeaderboardItem({
    super.key,
    required this.name,
    required this.position,
    required this.exp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Row(
            children: [
              Text(
                '# $position',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              const CircleAvatar(child: Icon(Icons.person_2_rounded)),
            ],
          ),
          const SizedBox(width: 10),
          Text(name),
          const Spacer(),
          Text(
            '$exp EXP',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
