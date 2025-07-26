import 'package:flutter/material.dart';

class ConfigTextButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icone;
  final String? titulo;
  final Color cor;
  final bool? isLoading;

  const ConfigTextButton({
    super.key,
    this.onTap,
    required this.icone,
    this.titulo,
    required this.cor,
    this.isLoading = false,
  });

  static Widget _content(
    bool isLoading,
    Color cor,
    String? titulo,
    IconData icone,
  ) {
    if (isLoading) return CircularProgressIndicator(color: cor);

    return Wrap(
      spacing: 2,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Icon(icone, color: cor),
        if (titulo != null && titulo.isNotEmpty) ...[
          Text(titulo, style: TextStyle(color: cor)),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading == false ? onTap : null,
      child: _content(isLoading == true, cor, titulo, icone),
    );
  }
}
