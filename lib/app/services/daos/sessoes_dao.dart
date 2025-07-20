import 'package:mochila_de_viagem/app/database/database_connect.dart';
import 'package:mochila_de_viagem/app/enums/segmento_enum.dart';
import 'package:mochila_de_viagem/app/models/sessao.dart';
import 'package:mochila_de_viagem/app/models/usuario.dart';

class SessoesDao {
  static const String _tableName = 'sessoes';
  static const String _tableQuery = '''
    CREATE TABLE $_tableName(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      segmento_id TEXT,
      usuario_id INTEGER,
      titulo VARCHAR(255),
      descricao TEXT,
      FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
    )
  ''';

  Future<List<Sessao>> index(SegmentoEnum segmento, Usuario usuario) async {
    final db = await openConnect(_tableQuery);
    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: 'segmento_id = ? AND usuario_id = ?',
      whereArgs: [segmento.titulo, usuario.id],
    );
    final List<Sessao> sessoes = [];
    for (Map<String, dynamic> row in result) {
      final Sessao sessao = Sessao.fromJson(row);
      sessoes.add(sessao);
    }
    return sessoes;
  }

  Future<int> store(Sessao sessao) async {
    final db = await openConnect(_tableQuery);
    final sessaoId = await db.insert(_tableName, sessao.toJson());

    return sessaoId;
  }
}
