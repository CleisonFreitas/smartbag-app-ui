import 'package:flutter/material.dart';
import 'package:mochila_de_viagem/core/constants/app_colors.dart';

class TextInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool readOnly;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? isSecret;

  const TextInput({
    super.key,
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.isSecret,
    this.suffixIcon,
    this.readOnly = false,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool get _isHidden => widget.isSecret == true;
  bool _exibirConteudo = true;
  @override
  void initState() {
    super.initState();
  }

  void _changeVisibility() {
    // Alterando a visibilidade
    _exibirConteudo = !_exibirConteudo;
    setState(() {});
  }

  Widget? _useIconButton() {
    IconData? suffixIcon = widget.suffixIcon;
    VoidCallback? evento;
    if (suffixIcon == null && !_isHidden) return null;

    if (_isHidden) {
      evento = () => _changeVisibility();
      suffixIcon = _exibirConteudo ? Icons.visibility_off : Icons.visibility;
    }
    return IconButton(onPressed: evento, icon: Icon(suffixIcon));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !_exibirConteudo,
      readOnly: widget.readOnly,
      enabled: !widget.readOnly,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        fillColor: AppColors.primary,
        iconColor: AppColors.primary,
        focusColor: Colors.white,
        hoverColor: Colors.white,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: _useIconButton(),
        contentPadding: EdgeInsets.all(8),
        label: Text(
          widget.label,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
