import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:notes/widgets/check_tile.dart';
import 'package:notes/widgets/note_type_button.dart';
class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController titleController = TextEditingController();

  bool _isChecked = false;

  List<Widget> checkTileList = [CheckTile(), CheckTile(), CheckTile()];

  Widget _checkTile(){
    return Row(
      children: [
        CircularCheckBox(
          inactiveColor: Colors.white,
          disabledColor: Colors.transparent,
          checkColor: Colors.green,
          value: _isChecked,
          onChanged: (value){
            setState(() {
              _isChecked = !_isChecked;
            });
          },
        ),
        SizedBox(width: 10.0,),
        Expanded(
          child: TextField(
            onSubmitted: (value){
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
              SizedBox(height: 60.0,),
              Text(DateTime.now().toString(), style: Theme.of(context).textTheme.bodyText1,),
              SizedBox(height: 20.0,),
              TextField(
                controller: titleController,
                onChanged: (value){
                  titleController.text.toUpperCase();
                },
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                  hintStyle: Theme.of(context).textTheme.headline5,
                ),
              ),
              SizedBox(height: 10.0,),
              Expanded(
                child: ListView(
                  children: checkTileList,
                ),
              ),
              Row(
                children: [
                  NoteTypeButton(
                    onTap: (){

                    },
                    label: "Info",
                    color: Colors.transparent,
                  ),
                  SizedBox(width: 20.0,),
                  NoteTypeButton(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return TodoPage();
                      }));
                    },
                    label: "Todo",
                    color: Colors.green,
                    borderColor: Colors.green,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .05,)
            ],
          )
      ),
    );
  }
}
