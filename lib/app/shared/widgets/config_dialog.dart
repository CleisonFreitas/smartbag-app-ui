import 'package:flutter/material.dart';
import 'package:mochila_de_viagem/app/shared/widgets/config_text_button.dart';
import 'package:mochila_de_viagem/core/constants/app_colors.dart';

class ConfigDialog extends StatefulWidget {
  final String message;
  final VoidCallback onConfirm;
  final IconData icon;
  final Color color;
  final bool isLoading;
  const ConfigDialog._(
    this.message,
    this.onConfirm,
    this.icon,
    this.color,
    this.isLoading,
  );

  static Future<ConfigDialog?> showDialogDanger(
    BuildContext context,
    String message,
    VoidCallback onConfirm,
    bool? isLoading,
  ) {
    return showDialog<ConfigDialog>(
      context: context,
      builder:
          (context) => ConfigDialog._(
            message,
            onConfirm,
            Icons.warning,
            Colors.black,
            isLoading == true,
          ),
    );
  }

  static Future<ConfigDialog?> showDialogInfo(
    BuildContext context,
    String message,
    VoidCallback onConfirm,
    bool? isLoading,
  ) {
    return showDialog<ConfigDialog>(
      context: context,
      builder:
          (context) => Dialog(
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 280, maxWidth: 480),
                  child: ConfigDialog._(
                    message,
                    onConfirm,
                    Icons.info,
                    AppColors.previsaoWarning,
                    isLoading == true,
                  ),
                );
              },
            ),
          ),
    );
  }

  @override
  State<ConfigDialog> createState() => _ConfigDialogState();
}

class _ConfigDialogState extends State<ConfigDialog> {
  IconData get _icon => widget.icon;
  String get _message => widget.message;
  Color get _color => widget.color;
  VoidCallback get _onConfirm => widget.onConfirm;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: AppColors.previsaoAlert),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(_icon, color: _color),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _message,
                      style: TextStyle(
                        color: _color,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.bottomRight,
                child: Wrap(
                  spacing: 8,
                  children: [
                    ConfigTextButton(
                      icone: Icons.cancel,
                      cor: Colors.black54,
                      onTap: () => Navigator.of(context).pop(),
                      titulo: 'Cancelar',
                    ),
                    ConfigTextButton(
                      icone: Icons.check_circle,
                      cor: _color,
                      onTap: widget.isLoading == true ? null : _onConfirm,
                      isLoading: widget.isLoading,
                      titulo: 'Confirmar',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
