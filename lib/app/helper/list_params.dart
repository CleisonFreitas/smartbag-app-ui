import 'package:mochila_de_viagem/app/models/filtro.dart';

class ListParams {
  final int page;
  final int perPage;
  final List<Filtro>? filtros;

  ListParams({this.page = 1, this.perPage = 20, this.filtros});

  Map<String, dynamic> toQueryParams() {
    final params = {'page': page.toString(), 'per_page': perPage.toString()};

    if (filtros != null && filtros!.isNotEmpty) {
      for (var i = 0; i < filtros!.length; i++) {
        final f = filtros![i];
        params['filters[$i][column]'] = f.column;
        params['filters[$i][value]'] = f.value.toString();
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
