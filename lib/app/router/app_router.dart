import 'package:go_router/go_router.dart';
import 'package:mochila_de_viagem/app/screens/auth/builders/register_screen.dart';
import 'package:mochila_de_viagem/app/screens/auth/register_body.dart';
import 'package:mochila_de_viagem/app/screens/home/splash_screen.dart';
import 'package:mochila_de_viagem/app/screens/home_screen.dart';

final GoRouter routerConfig = GoRouter(
  routes: <RouteBase>[
    GoRoute(path: '/', builder: (context, _) => SplashScreen()),
    GoRoute(
      path: '/register',
      builder:
          (context, _) => const RegisterScreen(registerBody: RegisterBody()),
    ),
    GoRoute(path: '/home', builder: (context, _) => const HomeScreen()),
  ],
);
