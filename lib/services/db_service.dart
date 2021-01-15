import 'package:notes/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  static Database _db;
  static const String dbName = "note.db";
  static const String noteTable = "noteTable";
  static const String colId = "id";
  static const String colTitle = "title";
  static const String colDesc = "description";
  static const String colTodo = "todo";
  static const String colDate = "date";

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
        "CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDesc TEXT, $colTodo TEXT, $colDate TEXT)");
  }

  Future<int> insertNote(Note note) async {
    Database dbClient = await db;
    int result;
    if (note != null) {
      result = await dbClient.insert(noteTable, note.toMap());
    }
    return result;
  }

  Future<int> updateNote(Note note) async {
    Database dbClient = await db;
    int result;
    if (noteTable != null) {
      result = await dbClient.update(noteTable, note.toMap(),
          where: "$colId = ?", whereArgs: [note.id]);
    }
    return result;
  }

  Future<int> deleteNote(Note note) async {
    Database dbClient = await db;
    int result;
    if (note != null) {
      int result = await dbClient
          .delete(noteTable, where: "$colId = ? ", whereArgs: [note.id]);
    }
    return result;
  }

  Future<List<Note>> getNotes() async {
    Database dbClient = await db;
    List<Map> map = await dbClient.query(noteTable,
        columns: [colId, colTitle, colDesc, colTodo, colDate]);
    return map.map((e) => Note.fromMapObject(e)).toList();
  }
}
