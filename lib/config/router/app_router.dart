import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/features/home/ui/screens/home_screen.dart';
import 'package:teraflex_mobile/features/welcome_messages/ui/screens/welcome_messages_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) {
        // validar que haya un usuario logueado
        const isUserLoggedIn = false;
        if (isUserLoggedIn) return const HomeScreen();
        return const WelcomeMessagesScreen();
      },
    ),
  ],
);
