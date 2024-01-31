import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teraflex_mobile/config/constants/environment.dart';
import 'package:teraflex_mobile/features/home/ui/blocs/global_summary/global_summary_cubit.dart';
import 'package:teraflex_mobile/features/leaderboard/domain/entities/leaderboard_row.dart';
import 'package:teraflex_mobile/features/leaderboard/ui/blocs/current_week_leaderboard/current_week_leaderboard_cubit.dart';
import 'package:teraflex_mobile/utils/rank.enum.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CurrentWeekLeaderboardCubit>().state;
    final stateGlobalSummary = context.watch<GlobalSummaryCubit>().state;

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
      return Column(
        children: [
          // rangos
          const LeaderboardRank(currentRank: Rank.renovacion),
          const Spacer(),
          Center(
            child: Text(
              state.statusMessage ?? 'No hay datos',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
        ],
      );
    }

    return Column(
      children: [
        LeaderboardRank(currentRank: stateGlobalSummary.globalSummary.rank),
        Leaderboard(leaderboard: state.leaderboard),
      ],
    );
  }
}

class Leaderboard extends StatelessWidget {
  final List<LeaderboardRow> leaderboard;

  const Leaderboard({super.key, required this.leaderboard});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: leaderboard.length,
        itemBuilder: (context, index) {
          final row = leaderboard[index];
          return LeaderboardItem(
            name: '${row.firstName} ${row.lastName}',
            position: index + 1,
            accuracy: row.accuracy,
          );
        },
      ),
    );
  }
}

class LeaderboardRank extends StatelessWidget {
  final Rank currentRank;

  const LeaderboardRank({
    super.key,
    required this.currentRank,
  });

  String get name {
    switch (currentRank) {
      case Rank.fortaleza:
        return 'Fortaleza';
      case Rank.superacion:
        return 'Superación';
      case Rank.renovacion:
        return 'Renovación';
      case Rank.recuperacion:
        return 'Recuperación';
      case Rank.crecimiento:
        return 'Crecimiento';
      case Rank.dominio:
        return 'Dominio';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: 70,
            child: ListView.builder(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: Rank.values.length,
              itemBuilder: (context, index) {
                final rank = Rank.values[index];
                return Row(
                  children: [
                    RankItem(
                      disabled: rank.index > currentRank.index,
                      image: 'assets/images/leaderboard/${index + 1}.png',
                      imageDisabled:
                          'assets/images/leaderboard/${index + 1}-disabled.png',
                      name: rank.name,
                    ),
                    const SizedBox(width: 30),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const Divider(height: 30),
        ],
      ),
    );
  }
}

class RankItem extends StatelessWidget {
  final bool disabled;
  final String image;
  final String imageDisabled;
  final String name;

  const RankItem({
    super.key,
    this.disabled = false,
    required this.image,
    required this.imageDisabled,
    required this.name,
  });

  String get asset {
    if (disabled) {
      return imageDisabled;
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(asset, width: 70);
  }
}

enum ComplianceStatus {
  up,
  down,
  none,
}

class LeaderboardItem extends StatelessWidget {
  final String name;
  final int position;
  final double accuracy;

  const LeaderboardItem({
    super.key,
    required this.name,
    required this.position,
    required this.accuracy,
  });

  ComplianceStatus get status {
    if (accuracy <= Environment.accuracyRankDown) {
      return ComplianceStatus.down;
    }

    if (accuracy <= Environment.accuracyRankSame) {
      return ComplianceStatus.none;
    }

    return ComplianceStatus.up;
  }

  Color get color {
    switch (status) {
      case ComplianceStatus.up:
        return Colors.greenAccent;
      case ComplianceStatus.down:
        return Colors.redAccent;
      case ComplianceStatus.none:
        return Colors.grey.shade300;
    }
  }

  IconData get icon {
    switch (status) {
      case ComplianceStatus.up:
        return Icons.expand_less_rounded;
      case ComplianceStatus.down:
        return Icons.expand_more_rounded;
      case ComplianceStatus.none:
        return Icons.remove_rounded;
    }
  }

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
          Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Icon(icon),
                Text(
                  '${accuracy * 100} %',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
