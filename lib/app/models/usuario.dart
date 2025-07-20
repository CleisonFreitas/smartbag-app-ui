class Usuario {
  final int? id;
  final String nome;
  final String email;
  final String? senha;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Usuario({
    this.id,
    required this.nome,
    required this.email,
    this.senha,
    this.createdAt,
    this.updatedAt,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'email': email,
      'senha': senha,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
