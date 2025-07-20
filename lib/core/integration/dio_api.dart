import 'package:dio/dio.dart';
import 'package:mochila_de_viagem/app/services/token/token_storage.dart';

class DioApi {
  final Dio _dio;
  final _tokenService = TokenStorage();
  DioApi()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'http://localhost:81/api/v1',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'Accept': 'application/json'},
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenService.recuperarToken('token-auth');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          _handleError(e);
          return handler.next(e);
        },
      ),
    );
  }

  Dio get cliente => _dio;
  Dio get viagem => _dio;
  Dio get sessao => _dio;

  void _handleError(DioException e) {
    final status = e.response?.statusCode;
    switch (status) {
      case 401:
        print('Unauthorized. Token might be expired.');
        break;
      case 422:
        print('Validation error: ${e.response?.data}');
        break;
      case 500:
        print('Server error: ${e.response?.data}');
        break;
      default:
        print('Error: $status ${e.message}');
    }
  }
}
