import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/config/theme/bloc/app_theme/app_theme_cubit.dart';
import 'package:teraflex_mobile/features/home/ui/blocs/global_summary/global_summary_cubit.dart';
import 'package:teraflex_mobile/features/home/ui/views/home_view.dart';
import 'package:teraflex_mobile/features/leaderboard/ui/blocs/current_week_leaderboard/current_week_leaderboard_cubit.dart';
import 'package:teraflex_mobile/features/leaderboard/ui/views/leaderboard_view.dart';
import 'package:teraflex_mobile/features/treatments/ui/blocs/simple_treatment_list/simple_treatment_list_cubit.dart';
import 'package:teraflex_mobile/features/treatments/ui/views/treatment_view.dart';
import 'package:teraflex_mobile/shared/widgets/custom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _views = [
    const HomeView(),
    const TreatmentView(),
    const LeaderboardView(),
  ];

  @override
  void initState() {
    super.initState();
    context.read<GlobalSummaryCubit>().getGlobalSummary();
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      context.read<GlobalSummaryCubit>().getGlobalSummary();
    }

    if (index == 1) {
      context.read<SimpleTreatmentListCubit>().loadSimpleTreatments();
    }

    if (index == 2) {
      context.read<CurrentWeekLeaderboardCubit>().getCurrentWeekLeaderboard();
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appThemeState = context.watch<AppThemeCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/home/logo.png', height: 30),
            const SizedBox(width: 10),
            const Text(
              'TeraFlex',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => context.read<AppThemeCubit>().toggleTheme(),
            icon: Icon(
              appThemeState.currentThemeState == ThemeState.light
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
            ),
          ),
          IconButton(
            onPressed: () => context.push('/notifications'),
            icon: const Icon(Icons.notifications_rounded),
          ),
          IconButton(
            onPressed: () => context.push('/settings'),
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _views,
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
