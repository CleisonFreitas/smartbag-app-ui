import 'package:flutter/material.dart';
import 'package:mochila_de_viagem/core/constants/app_colors.dart';

class ConfigButton {
  const ConfigButton._();

  static Widget _buildButton({
    required IconData? icon,
    required String title,
    required VoidCallback? onTap,
    required Color backgroundColor,
    required Color contentColor,
    required OutlinedBorder shape,
    double? width = double.maxFinite,
    bool? isLoading = false,
  }) {
    return Container(
      width: width,
      constraints: BoxConstraints(minHeight: 50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: shape,
        ),
        onPressed: onTap,
        child:
            isLoading == true
                ? CircularProgressIndicator(color: contentColor)
                : Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 5,
                  children: [
                    if (icon != null) Icon(icon, color: contentColor),
                    Text(
                      title,
                      style: TextStyle(color: contentColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
      ),
    );
  }

  static Widget primaryButton({
    IconData? icon,
    required String title,
    VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return _buildButton(
      icon: icon,
      title: title,
      onTap: onTap,
      isLoading: isLoading,
      backgroundColor: AppColors.primary,
      contentColor: Colors.white,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(3)),
    );
  }

  static Widget secondaryButton({
    IconData? icon,
    required String title,
    VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return _buildButton(
      icon: icon,
      title: title,
      onTap: onTap,
      backgroundColor: Colors.white,
      contentColor: AppColors.primary,
      isLoading: isLoading,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(3),
        side: const BorderSide(color: AppColors.primary),
      ),
    );
  }
}
