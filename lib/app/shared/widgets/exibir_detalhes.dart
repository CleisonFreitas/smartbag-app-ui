import 'package:flutter/material.dart';

class ExibirDetalhes extends StatelessWidget {
  final Widget widgetExibirDetalhes;
  const ExibirDetalhes._(this.widgetExibirDetalhes);

  static Future<void> exibirModal(
    BuildContext context,
    Widget widgetExibirDetalhes,
  ) {
    return showModalBottomSheet(
      useSafeArea: true,
      elevation: 8,
      isScrollControlled: true,
      context: context,
      builder: (context) => ExibirDetalhes._(widgetExibirDetalhes),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
        ),
        padding: EdgeInsets.only(
          top: 16.0,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.95,
          child: widgetExibirDetalhes,
        ),
      ),
    );
  }
}
