import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/db_service.dart';
import 'package:notes/widgets/note_type_button.dart';
import 'package:intl/intl.dart';

class AddNote extends StatefulWidget {
  final Note note;
  const AddNote(this.note);
  @override
  _AddNoteState createState() => _AddNoteState(note);
}

class _AddNoteState extends State<AddNote> {
  final Note note;
  _AddNoteState(this.note);
  DbService dbService = DbService();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  double _inputHeight = 50.0;
  bool isTodo = false;
  bool _validate = false;
  static List<String> friendsList = [null];
  static List<bool> toogles = [null];
  static List<Map<String, bool>> todoList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    descController.addListener(_checkInputHeight);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    descController.dispose();
    super.dispose();
  }

  void _checkInputHeight() async {
    int count = descController.text.split("\n").length;
    if (count == 0 && _inputHeight == 50.0) {
      return;
    }
    if (count <= 5) {
      var newHeight = count == 0 ? 50.0 : 28.0 + (count * 18.0);
      setState(() {
        _inputHeight = newHeight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //titleController.text = note.title;
    //descController.text = note.description;
    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTopDateTime(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      saveNote();
                      //todoList.add({friendsList[0]: toogles[0]});
                      //print(todoList);
                      //print(friendsList);
                      //print("-----------------");
                      //print(toogles);
                      //print(isTodo);
                      //updateTodo();
                    },
                  )
                ],
              ),
              //SizedBox(height: 20.0,),
              TextField(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                controller: titleController,
                cursorColor: Theme.of(context).primaryColor,
                onChanged: (value) {
                  updateTitle();
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                  hintStyle: Theme.of(context).textTheme.headline5,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: ListView(
                    padding: EdgeInsets.all(0.0),
                    physics: BouncingScrollPhysics(),
                    children: [
                      ..._getTodos(),
                    ]),
              ),
              //Spacer(),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  NoteTypeButton(
                    onTap: () {
                      setState(() {
                        isTodo = false;
                      });
                    },
                    label: "Info",
                    color: !isTodo ? Colors.green : Colors.transparent,
                    borderColor: !isTodo ? Colors.green : Colors.white,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  NoteTypeButton(
                    onTap: () {
                      setState(() {
                        isTodo = true;
                      });
                    },
                    label: "Todo",
                    color: isTodo ? Colors.green : Colors.transparent,
                    borderColor: isTodo ? Colors.green : Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
            ],
          )),
    );
  }

  TextField descTextField() {
    return TextField(
      style: TextStyle(color: Colors.white),
      controller: descController,
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      onChanged: (value) {
        updateDesc();
      },
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Note something down",
        hintStyle: Theme.of(context).textTheme.bodyText1,
        errorText: _validate ? "note something down" : null,
      ),
    );
  }

  List<Widget> _getTodos() {
    List<Widget> friendsTextFields = [];
    if (isTodo != true) {
      friendsTextFields.removeRange(0, friendsTextFields.length);
      friendsTextFields.add(descTextField());
    } else {
      friendsTextFields.removeRange(0, friendsTextFields.length);
      for (int i = 0; i < friendsList.length; i++) {
        friendsTextFields.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(child: TodoTextFields(i)),
              SizedBox(
                width: 16,
              ),
              // we need add button at last friends row
              _addRemoveButton(i == friendsList.length - 1, i),
            ],
          ),
        ));
      }
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (add) {
            // add new text-fields at the top of all friends textfields
            //todo fix the null initial issue
            toogles.insert(0, null);
            friendsList.insert(0, null);
          } else {
            toogles.removeAt(index);
            friendsList.removeAt(index);
          }
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDesc() {
    note.description = descController.text;
  }

  void updateTodo() {
    if (todoList.isNotEmpty) {
      todoList.removeRange(0, todoList.length - 1);
    }
    for (int i = 0; i < toogles.length; i++) {
      if (toogles[i] == null) {
        toogles[i] = false;
      }
    }
    print(toogles);
    todoList = [];
    for (int i = 0; i < friendsList.length; i++) {
      todoList.add({friendsList[i]: toogles[i]});
    }
    Map<String, bool> tempMap = {};
    for (var i in todoList) {
      tempMap.addAll(i);
    }
    note.todo = tempMap;
    print("````````````````````````````````````````````````");
    print(todoList);
    print(note.todo);
    // print(note.todo);
  }

  void saveNote() {
    if (isTodo == true) {
      note.description = null;
      setState(() {
        _TodoTextFieldsState.todoController.text.isEmpty
            ? _TodoTextFieldsState.validate = true
            : _TodoTextFieldsState.validate = false;
      });
      if (!_TodoTextFieldsState.validate) {
        updateTodo();
        save();
      }

      //save todo
    } else {
      note.todo = null;
      setState(() {
        descController.text.isEmpty ? _validate = true : _validate = false;
      });
      // save info
      if (!_validate) {
        save();
      }
    }
  }

  void save() async {
    int result;
    note.date = getTopDateTime();
    if (note.id == null) {
      //insert
      result = await dbService.insertNote(note);
    } else {
      //update
      //result = await dbService.updateNote(note);
    }
    if (result != 0) {
      Navigator.pop(context, true);
    }
  }

  String getTopDateTime() {
    DateTime now = DateTime.now();
    String currentTime = now.hour.toString() + ":" + now.minute.toString();
    String date = now.day.toString() + "," + now.year.toString();
    DateFormat formatter = DateFormat("MMM dd, yyyy");
    var formatted = formatter.format(now);
    String fullDate = formatted.toString() + " " + currentTime;
    return fullDate;
  }

  String getTileDate() {
    DateTime now = DateTime.now();
    String df = DateFormat.ABBR_MONTH;
    return df;
  }
}

class TodoTextFields extends StatefulWidget {
  final int index;
  TodoTextFields(this.index);
  @override
  _TodoTextFieldsState createState() => _TodoTextFieldsState();
}

class _TodoTextFieldsState extends State<TodoTextFields> {
  static TextEditingController todoController;
  //static var formKey = GlobalKey<FormState>();
  static bool validate = false;
  bool someBooleanValue = false;

  @override
  void initState() {
    super.initState();
    todoController = TextEditingController();
  }

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      todoController.text = _AddNoteState.friendsList[widget.index] ?? '';
      someBooleanValue = _AddNoteState.toogles[widget.index] ?? false;
      setState(() {});
    });

    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: todoController,
      onChanged: (v) {
        _AddNoteState.friendsList[widget.index] = v;
      },
      decoration: InputDecoration(
        icon: CircularCheckBox(
            checkColor: Colors.white,
            activeColor: Colors.green,
            inactiveColor: Colors.white,
            value: someBooleanValue,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            onChanged: (bool x) {
              setState(() {
                someBooleanValue = x;
                _AddNoteState.toogles[widget.index] = someBooleanValue;
              });
            }),
        hintText: 'TODO',
        errorText: validate ? "todo cannot be empty" : null,
        hintStyle: TextStyle(color: Colors.white30),
        border: InputBorder.none,
      ),
      validator: (v) {
        if (v.isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}
