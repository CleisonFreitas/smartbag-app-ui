class Cliente {
  final int? id;
  final String nome;
  final String email;
  final String? senha;
  final bool? ativo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  Cliente({
    this.id,
    required this.nome,
    required this.email,
    this.senha,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.ativo = true,
  });

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      if (ativo != null) 'ativo': ativo,
    };
  }

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      ativo: json['ativo'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt:
          json['deleted_at'] != null
              ? DateTime.parse(json['deleted_at'])
              : null,
    );
  }
}
