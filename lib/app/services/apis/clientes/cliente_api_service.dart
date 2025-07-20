import 'dart:convert';

import 'package:mochila_de_viagem/app/models/cliente.dart';
import 'package:mochila_de_viagem/app/services/token/token_storage.dart';
import 'package:mochila_de_viagem/core/integration/dio_api.dart';

class ClienteApiService {
  final DioApi _api;
  ClienteApiService() : _api = DioApi();

  Future<dynamic> cadastraCliente(Cliente cliente) async {
    final response = await _api.cliente.post(
      '/clientes/register',
      data: cliente.toJson(),
    );

    // Gravar token
    final tokenService = TokenStorage();
    tokenService.armazenarToken('token-auth', response.data['token']);
    final clienteFormated = jsonEncode(response.data['cliente']);
    tokenService.armazenarToken('cliente-auth', clienteFormated);
    return response.data;
  }

  Future<dynamic> loginCliente(Map<String, dynamic> dados) async {
    final response = await _api.cliente.post('/clientes/login', data: dados);
    final tokenService = TokenStorage();
    // Remover que o logout for montado.
    tokenService.excluirToken('token-auth');
    tokenService.excluirToken('cliente-auth');

    final cliente = jsonEncode(response.data['cliente']);

    tokenService.armazenarToken('token-auth', response.data['token']);
    tokenService.armazenarToken('cliente-auth', cliente);
    return response.data;
  }
}
