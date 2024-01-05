import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/features/auth/ui/screens/login_screen.dart';
import 'package:teraflex_mobile/features/home/ui/screens/home_screen.dart';
import 'package:teraflex_mobile/features/settings/ui/screens/profile/profile_view.dart';
import 'package:teraflex_mobile/features/settings/ui/screens/security/security_view.dart';
import 'package:teraflex_mobile/features/settings/ui/screens/setting_screen.dart';
import 'package:teraflex_mobile/features/treatments/ui/screens/treatment_tasks_screen.dart';
import 'package:teraflex_mobile/features/welcome_messages/ui/screens/welcome_messages_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const WelcomeMessagesScreen();
      },
    ),
    GoRoute(
      path: '/login',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'treatments',
          builder: (context, state) => const SizedBox(),
          routes: [
            GoRoute(
              path: ':id',
              name: TreatmentTasksScreen.name,
              builder: (context, state) {
                final treatmentId = state.pathParameters['id'] ?? 'no-id';
                return TreatmentTasksScreen(treatmentId: treatmentId);
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/settings',
      name: SettingScreen.name,
      builder: (context, state) => const SettingScreen(),
      routes: [
        GoRoute(
          path: 'profile',
          name: ProfileScreen.name,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: 'security',
          name: SecurityScreen.name,
          builder: (context, state) => const SecurityScreen(),
        ),
      ],
    ),
  ],
);
