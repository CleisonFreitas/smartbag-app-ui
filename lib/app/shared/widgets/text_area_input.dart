import 'package:flutter/material.dart';
import 'package:mochila_de_viagem/core/constants/app_colors.dart';

class TextAreaInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool? readOnly;
  const TextAreaInput({
    super.key,
    required this.label,
    required this.controller,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.primary,
      controller: controller,
      readOnly: readOnly == true,
      enabled: readOnly == false,
      maxLines: null,
      minLines: 5,
      decoration: InputDecoration(
        focusColor: AppColors.primary,
        fillColor: Colors.white,
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
          borderSide: BorderSide(color: Colors.red),
        ),
        label: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
