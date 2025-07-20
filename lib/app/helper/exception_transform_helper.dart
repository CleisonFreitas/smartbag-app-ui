import 'package:dio/dio.dart';

String formatarErroValidacao(DioException e) {
  try {
    final data = e.response?.data;
    if (data is Map && data.containsKey('errors')) {
      final errors = data['errors'] as Map<String, dynamic>;
      return errors.values
          .expand((messages) => messages as List)
          .map((m) => '* $m')
          .join('\n');
    }
    return data['message'] ?? 'Erro desconhecido';
  } catch (_) {
    return 'Falha na conexão: estamos com uma instabilidade no servidor';
  }
}
