import 'package:mochila_de_viagem/app/models/cliente.dart';
import 'package:mochila_de_viagem/app/models/viagem.dart';
import 'package:mochila_de_viagem/app/services/token/token_storage.dart';
import 'package:mochila_de_viagem/core/integration/dio_api.dart';

class ViagemApiService {
  final _tokenService = TokenStorage();
  final DioApi _api;
  ViagemApiService() : _api = DioApi();

  Future<dynamic> cadastrarViagem(Viagem viagem) async {
    final Cliente clienteLogado =
        _tokenService.recuperarToken('auth-cliente') as Cliente;
    final response = await _api.viagem.get(
      '/cliente/${clienteLogado.id}/viagens/store',
      data: viagem.toJson(),
    );

    return response.data;
  }
}
