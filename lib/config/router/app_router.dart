import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/features/auth/ui/screens/login_screen.dart';
import 'package:teraflex_mobile/features/home/ui/screens/home_screen.dart';
import 'package:teraflex_mobile/features/settings/ui/screens/setting_screen.dart';
import 'package:teraflex_mobile/features/welcome_messages/ui/screens/welcome_messages_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
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
    ),
    GoRoute(
      path: '/settings',
      name: SettingScreen.name,
      builder: (context, state) => const SettingScreen(),
    ),
  ],
);
