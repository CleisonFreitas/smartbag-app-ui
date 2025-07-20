import 'package:flutter/material.dart';
import 'package:mochila_de_viagem/app/shared/widgets/config_button.dart';
import 'package:mochila_de_viagem/core/constants/app_colors.dart';

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key});

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Nome:',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text('Cleison Freitas Ferreira'),
        ),
        ListTile(
          title: Text(
            'Email:',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text('cleison51@hotmail.com'),
        ),
        ListTile(
          title: Text(
            'Logado desde:',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text('03/07/2025 08:00'),
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            Expanded(
              child: ConfigButton.primaryButton(
                icon: Icons.people,
                title: 'Alterar usuário',
                onTap: () {},
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ConfigButton.secondaryButton(
                icon: Icons.password,
                title: 'Alterar senha',
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
