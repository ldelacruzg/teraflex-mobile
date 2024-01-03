import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int)? onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: onTap,
      selectedIndex: currentIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          label: 'Inicio',
          selectedIcon: Icon(Icons.home_rounded),
        ),
        NavigationDestination(
          icon: Icon(Icons.list_alt_outlined),
          label: 'Tratamientos',
          selectedIcon: Icon(Icons.list_alt_rounded),
        ),
        NavigationDestination(
          icon: Icon(Icons.leaderboard_outlined),
          label: 'Clasificación',
          selectedIcon: Icon(Icons.leaderboard_rounded),
        ),
      ],
    );
  }
}
