import 'package:nutricao_app/models/models.dart';
import 'package:sqflite/sqflite.dart' as sql;

class Database {

  
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE alimentos (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nome TEXT,
        foto TEXT,
        categoria TEXT,
        tipo TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      );
      """);

      await database.execute("""CREATE TABLE  cardapio (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        usu_id INTEGER,
        opcoes TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        );
        """
      );
  }

  static Future<sql.Database> database() async {
    return sql.openDatabase(
      'db_nutricao.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> insertAlimentos(String nome, String foto, String categoria, String tipo) async {
    final database = await Database.database();
    final data = {'nome': nome, 'senha': foto, 'categoria': categoria, 'tipo': tipo};
    final id = await database.insert('alimentos', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> insertCardapio(int usu_id, String opcoes) async {
    final database = await Database.database();
    final data = {'usu_id': usu_id, 'opcoes': opcoes};
    final id = await database.insert('alimentos', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getLlimentos() async {
    final database = await Database.database();
    return database.query('alimentos');
  }

  static Future<List<AlimentosModel>> getAlimentos() async {

    final database = await Database.database();
    final List<Map<String, dynamic>> alimentos = await database.query('alimentos');

    return List.generate(alimentos.length, (i) {
      return AlimentosModel(
        nome: alimentos[i]['nome'],
         foto: alimentos[i]['foto'],
          categoria: alimentos[i]['categoria'],
           tipo: alimentos[i]['tipo']);
    });
  }

  static listarAlimentos() async {

    sql.openDatabase('db_nutricao.db');
    final database = await Database.database();
    List alimentos = await database.rawQuery('select * from alimentos');

    return alimentos;
  }

}
