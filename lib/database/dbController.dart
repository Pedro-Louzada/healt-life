import 'package:nutricao_app/models/models.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';

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

      await database.execute("""CREATE TABLE  usuario (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nome TEXT,
        foto TEXT,
        dt_nascimento TEXT
        );
        """
      );
  }

  static Future<sql.Database> database() async {
    var dataPath = await sql.getDatabasesPath();
    String path = join(dataPath, 'db_nutricao.db');
    return sql.openDatabase(
      path,
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> insertAlimentos(String nome, String foto, String categoria, String tipo) async {
    final database = await Database.database();
    final data = {'nome': nome, 'foto': foto, 'categoria': categoria, 'tipo': tipo};
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

  static Future<int> insertUsuario(String nome, String foto, String dtNascimento) async {
    final database = await Database.database();
    final data = {'nome': nome, 'foto': foto, 'dt_nascimento': dtNascimento};
    final id = await database.insert('usuario', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAlimentos() async {
    final database = await Database.database();
    return database.query('alimentos');
  }

  static Future<List<Map<String, dynamic>>> getAlimentosByCategory(String categoria) async {
    final database = await Database.database();
    return database.rawQuery('select * from alimentos where categoria = "$categoria"');
  }

  static Future<List<Map<String, dynamic>>> getCardapio() async {
    final database = await Database.database();    
    return database.query('cardapio');
  }

  static deleteAlimentoByID(int id) async {
    final data = await Database.database();
    data.rawDelete('DELETE FROM alimentos where id = $id');
  }

  static Future<List<Map<String, dynamic>>> getUsuarios() async {
    final database = await Database.database();    
    return database.query('usuario');
  }

  static Future<List<Map<String, dynamic>>> getUsuarioById(int id) async {
    final database = await Database.database();    
    return database.rawQuery('SELECT * FROM alimentos where id = $id');
  }

  static Future<List<Map<String, dynamic>>> getUsuarioByLike(String search) async {
    final database = await Database.database();    
    return database.rawQuery('SELECT * FROM alimentos where nome like "%$search%" ');
  }
}
