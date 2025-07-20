import 'package:flutter/material.dart';
import 'package:mochila_de_viagem/core/constants/app_colors.dart';

class MainCard extends StatelessWidget {
  final String titulo;
  final IconData icone;
  const MainCard({super.key, required this.titulo, required this.icone});

  @override
  Widget build(BuildContext context) {
    final corPrincipal = AppColors.primary;
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: corPrincipal, width: 4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(child: Icon(icone, color: corPrincipal)),
          Expanded(child: Text(titulo, style: TextStyle(color: corPrincipal))),
        ],
      ),
    );
  }
}
