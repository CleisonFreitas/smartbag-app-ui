class PaginateItems<T> {
  final int currentPage;
  final int? previousPage;
  final int? nextPage;
  final int lastPage;
  final List<T> items;

  PaginateItems({
    required this.currentPage,
    required this.previousPage,
    required this.nextPage,
    required this.lastPage,
    required this.items,
  });

  factory PaginateItems.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final rawItems = json['items'];

    final list =
        (rawItems is List)
            ? rawItems.map((e) => fromJson(e as Map<String, dynamic>)).toList()
            : <T>[]; // fallback seguro

    return PaginateItems<T>(
      currentPage: json['current_page'] ?? 1,
      previousPage: json['previos_page'], // cuidado com o typo: está 'previos'
      nextPage: json['next_page'],
      lastPage: json['last_page'] ?? 1,
      items: list,
    );
  }
  @override
  String toString() =>
      'PaginateItems(currentPage: $currentPage, items: $items)';
}
