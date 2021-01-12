import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:notes/widgets/note_type_button.dart';
import 'package:intl/intl.dart';

class AddNote extends StatefulWidget {
  const AddNote();
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController _infoEditingController = TextEditingController();
  double _inputHeight = 50.0;
  bool isTodo = true;
  static List<String> friendsList = [null];

  _AddNoteState();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _infoEditingController.addListener(_checkInputHeight);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _infoEditingController.dispose();
    super.dispose();
  }

  void _checkInputHeight() async {
    int count = _infoEditingController.text.split("\n").length;
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
    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60.0,
              ),
              Text(
                getTopDateTime(),
                style: Theme.of(context).textTheme.bodyText1,
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
                      ..._getFriends(),
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
                        isTodo = true;
                      });
                    },
                    label: "Info",
                    color: isTodo ? Colors.green : Colors.transparent,
                    borderColor: isTodo ? Colors.green : Colors.white,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  NoteTypeButton(
                    onTap: () {
                      setState(() {
                        isTodo = false;
                      });
                    },
                    label: "Todo",
                    color: !isTodo ? Colors.green : Colors.transparent,
                    borderColor: !isTodo ? Colors.green : Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              )
            ],
          )),
    );
  }

  TextField descTextField() {
    return TextField(
      style: TextStyle(color: Colors.white),
      controller: _infoEditingController,
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      onChanged: (value) {
        updateInfo();
      },
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Note something down",
        hintStyle: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  List<Widget> _getFriends() {
    List<Widget> friendsTextFields = [];
    if (isTodo == true) {
      friendsTextFields.removeRange(0, friendsTextFields.length);
      friendsTextFields.add(descTextField());
    } else {
      friendsTextFields.removeRange(0, friendsTextFields.length);
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

  void updateTitle() {}

  void updateInfo() {}

  String getTopDateTime() {
    DateTime now = DateTime.now();
    String currentTime = now.hour.toString() + ":" + now.minute.toString();
    String date = now.day.toString() + "," + now.year.toString();
    DateFormat formatter = DateFormat("MMMM dd, yyyy");
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

class FriendTextFields extends StatefulWidget {
  final int index;
  FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  TextEditingController _nameController;

  bool someBooleanValue = false;

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
      _nameController.text = _AddNoteState.friendsList[widget.index] ?? '';
    });

    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: _nameController,
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
              });
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
