import 'package:app/models/encuesta.dart';
import 'package:app/schemas/encuesta_schema.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Logger logger = Logger();
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'encuestas.db'),
      onCreate: (db, _) {
        return db.execute(
          "CREATE TABLE encuestas ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "encuesta TEXT"
          "encuesta_id TEXT INDEX"
          ")",
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(EncuestaSchema encuestaSchema) async {
    Database database = await _openDB();
    await database.insert(
      'encuestas',
      encuestaSchema.toMap(),
    );
  }

  static Future<List<Encuesta>?> obtenerEncuestas() async {
    Database database = await _openDB();
    final response = await database.query('encuestas');
    List<Encuesta>? encuestas = [];
    for (final elemento in response) {
      String json = elemento["encuesta"] as String;
      encuestas.add(encuestaFromMap(json));
    }
    // response.map((e) {
    //   logger.i(e);
    // });
    return encuestas;
  }

  static Future<int> countEncuestas() async {
    Database database = await _openDB();
    int count = Sqflite.firstIntValue(
      await database.rawQuery('SELECT COUNT(*) FROM encuestas'),
    )!;
    return count;
  }
}
