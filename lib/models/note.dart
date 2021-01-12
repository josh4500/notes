import 'dart:convert';

class Note {
  int id;
  String title;
  String description;
  List<Map<String, bool>> todo;
  String date;

  Note({this.title, this.description, this.todo, this.date});

  Note.fromMapObject(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    description = map["description"];
    List<Map<String, bool>> todoDecode = jsonDecode(map["todo"]);
    todo = todoDecode;
    date = map["date"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = id;
    }
    map["title"] = title;
    map["description"] = description;
    String todoEncode = jsonEncode(todo);
    map["todo"] = todoEncode;
    map["date"] = date;
    return map;
  }
}
