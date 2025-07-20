import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openConnect(String queryTable) async {
  final dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'mochila_de_viagem.db');
  return openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(queryTable);
    },
    onConfigure: (db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    },
    onDowngrade: (db, oldVersion, newVersion) => onDatabaseDowngradeDelete,
    version: 1,
  );
}
