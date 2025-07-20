import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mochila_de_viagem/app/services/token/token_storage.dart';
import 'package:mochila_de_viagem/core/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _tokenService = TokenStorage();
  @override
  void initState() {
    _onStartScreen();
    super.initState();
  }

  Future<void> _onStartScreen() async {
    final clientExists = await _tokenService.recuperarToken('cliente-auth');
    if (!mounted) return;

    final String route = clientExists != null ? '/home' : '/register';

    GoRouter.of(context).go(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }
}
