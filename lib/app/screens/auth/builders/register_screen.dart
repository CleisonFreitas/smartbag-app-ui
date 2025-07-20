import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mochila_de_viagem/app/blocs/auth/registrar_bloc_logic.dart';

class RegisterScreen extends StatelessWidget {
  final Widget registerBody;
  const RegisterScreen({super.key, required this.registerBody});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegistrarBlocLogic(),
      child: registerBody,
    );
  }
}
