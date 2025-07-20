import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mochila_de_viagem/app/blocs/auth/registrar_bloc_event.dart';
import 'package:mochila_de_viagem/app/blocs/auth/registrar_bloc_logic.dart';
import 'package:mochila_de_viagem/app/blocs/auth/registrar_bloc_state.dart';
import 'package:mochila_de_viagem/app/models/cliente.dart';
import 'package:mochila_de_viagem/app/screens/auth/login_screen.dart';
import 'package:mochila_de_viagem/app/shared/validations/app_validations.dart';
import 'package:mochila_de_viagem/app/shared/widgets/config_button.dart';
import 'package:mochila_de_viagem/core/constants/app_colors.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final RegistrarBlocLogic _registrarBloc;

  @override
  void initState() {
    super.initState();
    _registrarBloc = context.read<RegistrarBlocLogic>();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final cliente = Cliente(
        nome: _nameController.text,
        email: _emailController.text,
        senha: _passwordController.text,
      );
      _registrarBloc.add(SubmitRegistrarEvent(cliente));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _registrarBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrarBlocLogic(),
      child: Scaffold(
        body: SafeArea(
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 16.0,
            ),
            child: BlocProvider.value(
              value: _registrarBloc,
              child: BlocListener<RegistrarBlocLogic, RegistrarBlocState>(
                listener: (context, state) {
                  if (state is RegistrarSuccessfulState) {
                    context.go('/home');
                  } else if (state is RegistrarErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.response,
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: BlocBuilder<RegistrarBlocLogic, RegistrarBlocState>(
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Bem-vindo ao smartBag',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(label: Text('Nome')),
                            validator: (value) => nomeValidate(value),
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(label: Text('Email')),
                            validator: (value) => emailValidate(value),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(label: Text('Senha')),
                            validator: (value) => senhaValidate(value),
                            obscureText: true,
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.topRight,
                            child: Wrap(
                              spacing: 5,
                              children: <Widget>[
                                Text('Já possui uma conta?'),
                                InkWell(
                                  child: Text(
                                    'Faça login',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  onTap:
                                      () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return LoginScreen();
                                          },
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          ConfigButton.primaryButton(
                            icon: null,
                            title: 'Registrar',
                            onTap: _onSubmit,
                            isLoading: state is RegistrarLoadingState,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
