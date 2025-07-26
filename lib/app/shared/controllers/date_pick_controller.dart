import 'package:flutter/material.dart';
import 'package:mochila_de_viagem/core/constants/app_colors.dart';

class DatePickController extends ChangeNotifier {
  DateTime? dataSelecionada;

  Future<void> selectDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dataSelecionada,
      firstDate: DateTime(DateTime.now().day),
      lastDate: DateTime(DateTime.now().year + 4),
      keyboardType: TextInputType.numberWithOptions(),
      fieldLabelText: 'Selecione uma data',
      helpText: 'Selecionar data',
      locale: Locale('pt', 'BR'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              secondary: AppColors.secondary,
              tertiary: AppColors.previsaoAlert,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      dataSelecionada = pickedDate;
    }
    notifyListeners();
  }
}
