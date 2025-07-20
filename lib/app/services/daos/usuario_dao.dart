import 'package:mochila_de_viagem/app/database/database_connect.dart';
import 'package:mochila_de_viagem/app/models/usuario.dart';

class UsuarioDao {
  static const String _tableName = 'usuarios';
  static const _tableQuery = '''
    CREATE TABLE $_tableName(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome VARCHAR(255),
      email VARCHAR(255) UNIQUE,
      senha VARCHAR(255), 
      created_at DATETIME,
      updated_at DATETIME
    )
  ''';

  Future<List<Usuario>> index() async {
    final db = await openConnect(_tableQuery);
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    final List<Usuario> usuarios = [];

    for (Map<String, dynamic> row in result) {
      final Usuario usuario = Usuario.fromJson(row);
      usuarios.add(usuario);
    }

    return usuarios;
  }

  Future<int> store(Usuario usuario) async {
    try {
      final db = await openConnect(_tableQuery);
      final novoUsuario = await db.insert(_tableName, usuario.toJson());
      return novoUsuario;
    } catch (e) {
      rethrow;
    }
  }

  Future<Usuario> show(Usuario usuario) async {
    try {
      final db = await openConnect(_tableQuery);
      final queryUsuario = await db.query(
        _tableName,
        where: 'id = ?',
        whereArgs: [usuario.id],
      );
      final usuarioEncontrado = queryUsuario.first;
      return Usuario.fromJson(usuarioEncontrado);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> update(Usuario usuario, Usuario usuarioAtualizado) async {
    try {
      final db = await openConnect(_tableQuery);
      final usuarioId = await db.update(
        _tableName,
        usuarioAtualizado.toJson(),
        where: 'id = ?',
        whereArgs: [usuario.id],
      );
      return usuarioId;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> delete(Usuario usuario) async {
    try {
      final db = await openConnect(_tableQuery);
      final usuarioId = await db.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [usuario.id],
      );
      return usuarioId;
    } catch (e) {
      rethrow;
    }
  }
}
