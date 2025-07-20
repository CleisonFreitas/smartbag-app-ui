String? emailValidate(String? email) {
  if (email == null || email.isEmpty) {
    return 'O campo e-mail é obrigatório.';
  }

  final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(email)) {
    return 'E-mail inválido.';
  }

  return null;
}

String? nomeValidate(String? nome) {
  if (nome == null || nome.isEmpty) {
    return 'O campo nome é obrigatório';
  }

  if (nome.length < 5) {
    return 'O campo nome precisa possuir um valor válido';
  }

  return null;
}

String? senhaValidate(String? senha) {
  if (senha == null || senha.isEmpty) {
    return 'O campo senha é obrigatório';
  }

  if (senha.length < 8) {
    return 'O campo senha deve possuir no mínimo 8 dígitos';
  }

  return null;
}
