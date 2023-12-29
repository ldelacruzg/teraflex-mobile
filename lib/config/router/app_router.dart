import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/features/home/ui/screens/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    )
  ],
);
