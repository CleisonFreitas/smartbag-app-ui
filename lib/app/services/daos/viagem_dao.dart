import 'package:mochila_de_viagem/app/database/database_connect.dart';
import 'package:mochila_de_viagem/app/models/viagem.dart';

class ViagemDao {
  static const String _tableName = 'viagens';
  static const String _tableQuery =
      'CREATE TABLE viagem('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'local TEXT )';

  Future<List<Viagem>> buscar(
    DateTime? dataDePartida,
    DateTime? dataDeChegada,
  ) async {
    final db = await openConnect(_tableQuery);
    List<Map<String, dynamic>> result = [];
    if (dataDePartida != null && dataDeChegada != null) {
      result = await db.query(
        _tableName,
        where: 'data_de_partida = ? AND data_de_chegada = ?',
        whereArgs: [dataDePartida.toLocal(), dataDeChegada.toLocal()],
      );
    } else {
      result = await db.query(_tableName);
    }

    final List<Viagem> viagens = [];

    for (Map<String, dynamic> row in result) {
      final Viagem usuario = Viagem.fromJson(row);
      viagens.add(usuario);
    }
    return viagens;
  }

  Future<int> store(Viagem viagem) async {
    final db = await openConnect(_tableQuery);
    final viagemId = await db.insert(_tableName, viagem.toJson());
    return viagemId;
  }

  Future<int> update(Viagem viagem, Viagem viagemAtualizada) async {
    final db = await openConnect(_tableQuery);
    final viagemId = await db.update(
      _tableName,
      viagemAtualizada.toJson(),
      where: 'id = ?',
      whereArgs: [viagem.id],
    );

    return viagemId;
  }
}
