import 'package:json_annotation/json_annotation.dart';
//part 'note.g.dart';
//@JsonSerializable()
class Note{
  int _id;
  bool _isTodo;
  String _title;
  String _infoNote;
  String _date;
  List<TodoNote> _todoNote;

  Note(this._isTodo, this._title, this._infoNote, this._date, this._todoNote);

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["id"] = _id;
    map["isTodo"] = _isTodo;
    map["title"] = _title;
    map["infoNote"] = _infoNote;
    map["date"] = _date;
    map["todoNote"] = _todoNote;
    return map;

  }

  Note.fromMapObject(Map<String, dynamic> map){
    var todo = map["todoNote"] as List;
    List<TodoNote> todoNote = todo.map((e) => TodoNote.fromMapObject(e)).toList();
    _id = map["id"];
    _isTodo = map["isTodo"];
    _title = map["title"];
    _infoNote = map["infoNote"];
    _date = map["date"];
    _todoNote = todoNote;

  }

  int get id => _id;

  // ignore: unnecessary_getters_setters
  bool get isTodo => _isTodo;

  // ignore: unnecessary_getters_setters
  set isTodo(bool value) {
    _isTodo = value;
  }

  // ignore: unnecessary_getters_setters
  String get title => _title;

  // ignore: unnecessary_getters_setters
  set title(String value) {
    _title = value;
  }

  // ignore: unnecessary_getters_setters
  String get infoNote => _infoNote;

  // ignore: unnecessary_getters_setters
  set infoNote(String value) {
    _infoNote = value;
  }

  // ignore: unnecessary_getters_setters
  String get date => _date;

  // ignore: unnecessary_getters_setters
  set date(String value) {
    _date = value;
  }

  // ignore: unnecessary_getters_setters
  List<TodoNote> get todoNote => _todoNote;

  // ignore: unnecessary_getters_setters
  set todoNote(List<TodoNote> value) {
    _todoNote = value;
  }

}

class TodoNote{
  bool _isChecked;
  String _info;

  TodoNote(this._isChecked, this._info);

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["isChecked"] = _isChecked;
    map["info"] = _isChecked;
    return map;
  }

  TodoNote.fromMapObject(Map<String, dynamic> map){
    _isChecked = map["isChecked"];
    _info = map["info"];
  }
  // ignore: unnecessary_getters_setters
  bool get isChecked => _isChecked;

  // ignore: unnecessary_getters_setters
  set isChecked(bool value) {
    _isChecked = value;
  }

  // ignore: unnecessary_getters_setters
  String get info => _info;

  // ignore: unnecessary_getters_setters
  set info(String value) {
    _info = value;
  }
}
