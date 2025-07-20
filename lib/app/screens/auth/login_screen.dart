import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mochila_de_viagem/app/blocs/auth/login_event.dart';
import 'package:mochila_de_viagem/app/blocs/auth/login_logic.dart';
import 'package:mochila_de_viagem/app/blocs/auth/login_state.dart';
import 'package:mochila_de_viagem/app/shared/validations/app_validations.dart';
import 'package:mochila_de_viagem/app/shared/widgets/config_button.dart';
import 'package:mochila_de_viagem/core/constants/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _loginBloc = LoginLogic();

  @override
  void initState() {
    super.initState();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      if (!mounted) return;

      _loginBloc.add(
        SubmitLoginEvent(_emailController.text, _passwordController.text),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
          child: BlocProvider.value(
            value: _loginBloc,
            child: BlocListener<LoginLogic, LoginState>(
              listenWhen: (previous, current) => previous != current,
              listener: (BuildContext context, LoginState state) {
                if (state is LoginSuccessfulState) {
                  context.go('/home');
                } else if (state is LoginErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
              },
              child: BlocBuilder<LoginLogic, LoginState>(
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      spacing: 10,
                      children: <Widget>[
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(label: Text('Email')),
                          validator: (value) => emailValidate(value),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(label: Text('Senha')),
                          validator: (value) => senhaValidate(value),
                        ),
                        const SizedBox(height: 10),
                        ConfigButton.primaryButton(
                          title: 'Acessar',
                          icon: null,
                          onTap: _onSubmit,
                          isLoading: state is LoginLoadingState,
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
    );
  }
}
