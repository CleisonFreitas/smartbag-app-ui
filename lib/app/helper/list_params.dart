import 'package:mochila_de_viagem/app/models/filtro.dart';
import 'package:mochila_de_viagem/app/models/ordem.dart';

class ListParams {
  final int page;
  final int perPage;
  final List<Filtro>? filtros;
  final List<Ordem>? ordens;

  ListParams({this.page = 1, this.perPage = 5, this.filtros, this.ordens});

  Map<String, dynamic> toQueryParams() {
    Map<String, dynamic> params = {'page': page, 'per_page': perPage};
    params = _generateSearchableParams(params, 'filters'); // insere os filtros
    params = _generateSearchableParams(params, 'orders'); // insere ordenação.
    return params;
  }

  Map<String, dynamic> _generateSearchableParams(
    Map<String, dynamic> params,
    String searchable,
  ) {
    final fitParams = {'filters': filtros, 'orders': ordens};
    // fitParams[searchable] equivale à filtros ou ordens
    if (fitParams[searchable] != null && fitParams[searchable]!.isNotEmpty) {
      for (int i = 0; i < fitParams[searchable]!.length; i++) {
        final search = fitParams[searchable]![i];
        params['$searchable[$i][column]'] = search.column;
        params['$searchable[$i][value]'] = search.value;
      }
    }
    return params;
  }

  ListParams copyWith({int? page, int? perPage, List<Filtro>? filtros}) {
    return ListParams(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      filtros: filtros ?? this.filtros,
    );
  }
}
