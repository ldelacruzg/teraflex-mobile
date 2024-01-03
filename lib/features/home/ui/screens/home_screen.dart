import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/features/home/ui/views/home_view.dart';
import 'package:teraflex_mobile/features/leaderboard/ui/views/leaderboard_view.dart';
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

  final List<Widget> _views = const [
    HomeView(),
    TreatmentView(),
    LeaderboardView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
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
