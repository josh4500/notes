import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:intl/intl.dart';
import 'package:notes/models/note.dart';
import 'package:notes/pages/info_page.dart';
import 'package:notes/widgets/check_tile.dart';
import 'package:notes/widgets/note_type_button.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController titleController = TextEditingController();
  static List<String> friendsList = [null];
  bool _isChecked = false;
  static List<TodoNote> todoList = [null];

  List<Widget> checkTileList = [CheckTile(), CheckTile(), CheckTile()];

  Widget _checkTile() {
    return Row(
      children: [
        CircularCheckBox(
          inactiveColor: Colors.white,
          disabledColor: Colors.transparent,
          checkColor: Colors.green,
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = !_isChecked;
            });
          },
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: TextField(
            onSubmitted: (value) {
              checkTileList.add(_checkTile());
            },
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    getDateTime(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  IconButton(
                    iconSize: 28.0,
                    icon: Icon(Icons.check),
                    onPressed: () {
                      //print(friendsList);
                      print(todoList.first);
                    },
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: titleController,
                onChanged: (value) {
                  titleController.text.toUpperCase();
                },
                cursorColor: Theme.of(context).primaryColor,
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
                child: ListView(physics: BouncingScrollPhysics(), children: [
                  ..._getFriends(),
                ]),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  NoteTypeButton(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return InfoPage();
                      }));
                    },
                    label: "Info",
                    color: Colors.transparent,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  NoteTypeButton(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return TodoPage();
                      }));
                    },
                    label: "Todo",
                    color: Colors.green,
                    borderColor: Colors.green,
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

  List<Widget> _getFriends() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < friendsList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: FriendTextFields(i)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(i == friendsList.length - 1, i),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          friendsList.insert(0, null);
        } else
          friendsList.removeAt(index);
        setState(() {});
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

  String getDateTime() {
    DateTime now = DateTime.now();
    String currentTime = now.hour.toString() + ":" + now.minute.toString();
    String date = now.day.toString() + "," + now.year.toString();
    DateFormat formatter = DateFormat("MMM dd, yyyy");
    var formatted = formatter.format(now);
    String fullDate = formatted.toString() + " " + currentTime;
    return fullDate;
  }
}

class FriendTextFields extends StatefulWidget {
  final int index;
  FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  TextEditingController _nameController;

  bool someBooleanValue = false;
  TodoNote todoNote;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = _TodoPageState.friendsList[widget.index] ?? '';
    });

    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: _nameController,
      onChanged: (v) {
        _TodoPageState.friendsList[widget.index] = v;
        _TodoPageState.todoList[widget.index].info = v;
      },
      decoration: InputDecoration(
        icon: CircularCheckBox(
            checkColor: Colors.white,
            activeColor: Colors.green,
            inactiveColor: Colors.white,
            value: someBooleanValue,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            onChanged: (bool x) {
              //_TodoPageState.todoList[widget.index].isChecked = x;
              setState(() {
                someBooleanValue = x;
              });

              //print("wotreksxjhvhfdnjdfcnj,jdbmhbfhmbvfhebfewnmbjjsdcmc s");
            }),
        hintText: 'TODO',
        hintStyle: TextStyle(color: Colors.white30),
        border: InputBorder.none,
      ),
      validator: (v) {
        if (v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}
