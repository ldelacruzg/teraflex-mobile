import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teraflex_mobile/features/leaderboard/ui/blocs/current_week_leaderboard/current_week_leaderboard_cubit.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CurrentWeekLeaderboardCubit>().state;

    if (state.status == StatusUtil.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == StatusUtil.error) {
      return Center(
        child: Text(state.statusMessage ?? 'Lo sentimos, ha ocurrido un error'),
      );
    }

    if (state.status == StatusUtil.none) {
      return Center(
        child: Text(state.statusMessage ?? 'No hay usuario logueado'),
      );
    }

    if (state.status == StatusUtil.empty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Text(
            state.statusMessage ?? 'No hay datos',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: state.leaderboard.length,
      itemBuilder: (context, index) {
        final row = state.leaderboard[index];
        return LeaderboardItem(
          name: '${row.firstName} ${row.lastName}',
          position: index + 1,
          exp: row.accuracy * 100,
        );
      },
    );
  }
}

class LeaderboardItem extends StatelessWidget {
  final String name;
  final int position;
  final double exp;

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
            '$exp %',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
