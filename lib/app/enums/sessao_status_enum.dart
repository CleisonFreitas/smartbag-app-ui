enum SessaoStatusEnum {
  pendente('PENDENTE', 'Pendente'),
  concluido('CONCLUIDO', 'Concluido');

  final String titulo;
  final String tituloAmigavel;

  const SessaoStatusEnum(this.titulo, this.tituloAmigavel);
}
