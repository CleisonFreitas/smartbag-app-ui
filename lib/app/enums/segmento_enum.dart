import 'package:flutter/material.dart';

enum SegmentoEnum {
  alimentacao('ALIMENTACAO', 'Alimentação', Icons.fastfood),
  transporte('TRANSPORTE', 'Transporte', Icons.flight),
  acomodacao('ACOMODOCAO', 'Acomodação', Icons.house),
  higiene('HIGIENE', 'Higiêne', Icons.clean_hands),
  documentacao('DOCUMENTOS', 'Documentos', Icons.attach_file),
  medicamentos('FARMACIA', 'Farmácia', Icons.medical_information),
  bagagem('BAGAGEM', 'Bagagem', Icons.backpack),
  dispositivos('DISPOSITIVOS', 'Dispositivos', Icons.devices_outlined);

  final String titulo;
  final String tituloAmigavel;
  final IconData icone;

  static SegmentoEnum fromTitulo(String segmentoId) {
    return SegmentoEnum.values.firstWhere(
      (segmento) => segmento.titulo == segmentoId,
    );
  }

  const SegmentoEnum(this.titulo, this.tituloAmigavel, this.icone);
}
