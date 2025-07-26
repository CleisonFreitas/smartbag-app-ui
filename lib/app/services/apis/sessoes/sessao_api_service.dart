import 'package:mochila_de_viagem/app/helper/list_params.dart';
import 'package:mochila_de_viagem/app/models/paginate.dart';
import 'package:mochila_de_viagem/app/models/sessao.dart';
import 'package:mochila_de_viagem/core/integration/dio_api.dart';

class SessaoApiService {
  final _dio = DioApi();

  Future<dynamic> cadastrar(Sessao sessao) async {
    final response = await _dio.sessao.post('/sessoes', data: sessao.toJson());
    return response.data;
  }

  Future<dynamic> atualizar(Sessao sessao) async {
    final response = await _dio.sessao.put(
      '/sessoes/${sessao.id}',
      data: sessao.toJson(),
    );
    return response.data;
  }

  Future<PaginateItems<Sessao>> buscar(ListParams params) async {
    final response = await _dio.sessao.get(
      '/sessoes',
      queryParameters: params.toQueryParams(),
    );
    return PaginateItems<Sessao>.fromJson(
      response.data,
      (json) => Sessao.fromJson(json),
    );
  }
}
