import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mochila_de_viagem/app/shared/controllers/date_pick_controller.dart';
import 'package:mochila_de_viagem/core/constants/app_colors.dart';

class DatePickerInput extends StatefulWidget {
  final String label;
  final bool? readOnly;
  final String? value;
  final DatePickController controller;
  const DatePickerInput({
    super.key,
    required this.label,
    this.readOnly = false,
    this.value,
    required this.controller,
  });

  @override
  State<DatePickerInput> createState() => _DatePickerInputState();
}

class _DatePickerInputState extends State<DatePickerInput> {
  DatePickController get _datePickerController => widget.controller;
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _datePickerController,
      builder: (context, state) {
        String dataAtual = '';
        if (_datePickerController.dataSelecionada != null) {
          dataAtual = DateFormat(
            'dd/MM/yyy',
          ).format(_datePickerController.dataSelecionada!);
        }
        return Wrap(
          direction: Axis.vertical,
          crossAxisAlignment:
              dataAtual.isNotEmpty
                  ? WrapCrossAlignment.start
                  : WrapCrossAlignment.center,
          alignment:
              dataAtual.isNotEmpty ? WrapAlignment.start : WrapAlignment.center,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed:
                  widget.readOnly == true
                      ? null
                      : () async =>
                          await _datePickerController.selectDatePicker(context),
              label: Text(
                dataAtual,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
              icon: Icon(Icons.calendar_month),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                iconColor: AppColors.primary,
                iconAlignment:
                    dataAtual.isNotEmpty
                        ? IconAlignment.start
                        : IconAlignment.end,
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        );
      },
    );
  }
}
