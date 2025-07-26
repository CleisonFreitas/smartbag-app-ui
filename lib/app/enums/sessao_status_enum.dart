enum SessaoStatusEnum {
  pendente('PENDENTE', 'Pendente'),
  concluido('CONCLUIDO', 'Concluido');

  final String titulo;
  final String tituloAmigavel;

  const SessaoStatusEnum(this.titulo, this.tituloAmigavel);

  static SessaoStatusEnum fromStatusInformado(String? statusInformado) {
    return SessaoStatusEnum.values.firstWhere(
      (status) => status.titulo == statusInformado,
      orElse: () => SessaoStatusEnum.pendente,
    );
  }
}
