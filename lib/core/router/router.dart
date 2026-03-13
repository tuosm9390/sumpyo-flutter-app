import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/main_layout.dart';
import '../../features/home/presentation/pages/intro_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const IntroPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainLayout(),
    ),
  ],
);
