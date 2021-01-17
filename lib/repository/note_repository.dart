import 'package:notes/models/note.dart';
import 'package:notes/models/note_dept.dart';
import 'package:notes/services/db_service.dart';

class NoteRepo extends NoteDept {
  int id;
  String title;
  String description;
  List<Map<String, bool>> todo;
  String date;

  static Future<List<NoteRepo>> getRefinedNote() async {
    DbService dbService = DbService();
    List<NoteRepo> noteRepo = List<NoteRepo>();
    //List<Map<String, bool>> todo = [];
    List<Note> notes = await dbService.getNotes();
    if (notes[0].todo != null) {
      notes.map((e) {
        for (int i = 0; i < e.todo.length ?? 0; i++) {
          //e.todo.cast<String, bool>();
        }
      }).toList();
      for (int i = 0; i < notes.length; i++) {
        notes.map((e) {
          noteRepo[i].id = e.id;
          noteRepo[i].title = e.title;
          noteRepo[i].description = e.description;
          //noteRepo[i].todo.add(e.todo);
          noteRepo[i].date = e.date;
        }).toList();
      }
    } else {
      for (int i = 0; i < notes.length ?? 0; i++) {
        notes.map((e) {
          noteRepo[i].id = e.id;
          noteRepo[i].title = e.title;
          noteRepo[i].description = e.description;
          //noteRepo[i].todo.add(e.todo);
          noteRepo[i].date = e.date;
        }).toList();
      }
    }
    return noteRepo;
  }
}
