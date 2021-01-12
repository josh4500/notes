import 'package:notes/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  static Database _db;
  static const String dbName = "note.db";
  static const String noteTable = "noteTable";
  static const String colId = "colId";
  static const String colTitle = "colTitle";
  static const String colDesc = "colDesc";
  static const String colTodo = "colTodo";
  static const String colDate = "colDate";

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), dbName);
    Database noteDB = await openDatabase(path, onCreate: _onCreate, version: 1);
    return noteDB;
  }

  void _onCreate(Database database, int version) async {
    await database.execute(
        "CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDesc TEXT $colTodo TEXT, $colDate TEXT)");
  }

  Future<bool> insertNote(Note note) async {
    Database dbClient = await db;
    bool isSuccess = false;
    if (note != null) {
      int result = await dbClient.insert(noteTable, note.toMap());
      isSuccess = result == 1 ? true : false;
    }
    return isSuccess;
  }

  Future<bool> updateNote(Note note) async {
    Database dbClient = await db;
    bool isSuccess = false;
    if (noteTable != null) {
      int result = await dbClient.update(noteTable, note.toMap(),
          where: "$colId = ?", whereArgs: [note.id]);
      isSuccess = result == 1 ? true : false;
    }
    return isSuccess;
  }

  Future<bool> deleteNote(Note note) async {
    Database dbClient = await db;
    bool isSuccess = false;
    if (note != null) {
      int result = await dbClient
          .delete(noteTable, where: "$colId = ? ", whereArgs: [note.id]);
      isSuccess = result == 1 ? true : false;
    }
    return isSuccess;
  }

  Future<List<Note>> getNotes() async {
    Database dbClient = await db;
    List<Map> map = await dbClient.query(noteTable);
    return map.map((e) => Note.fromMapObject(e)).toList();
  }
}
