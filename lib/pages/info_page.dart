import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/pages/todo_page.dart';
import 'package:notes/widgets/note_type_button.dart';
import 'package:intl/intl.dart';

class InfoPage extends StatefulWidget {
  const InfoPage();
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController _infoEditingController = TextEditingController();
  double _inputHeight = 50.0;

  _InfoPageState();
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
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      TextField(
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
                      ),
                    ]),
              ),
              //Spacer(),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  NoteTypeButton(
                    onTap: () {},
                    label: "Info",
                    color: Colors.green,
                    borderColor: Colors.green,
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
                    color: Colors.transparent,
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
