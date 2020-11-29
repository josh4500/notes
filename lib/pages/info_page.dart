import 'package:flutter/material.dart';
import 'package:notes/pages/todo_page.dart';
import 'package:notes/widgets/note_type_button.dart';
class InfoPage extends StatefulWidget {

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController _textEditingController = TextEditingController();
  double _inputHeight = 50.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController.addListener(_checkInputHeight);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    super.dispose();
  }

  void _checkInputHeight() async {
    int count = _textEditingController.text.split("\n").length;
    if(count == 0 && _inputHeight == 50.0){
      return;
    }
    if(count <= 5){
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
            SizedBox(height: 60.0,),
            Text(DateTime.now().toString(), style: Theme.of(context).textTheme.bodyText1,),
            //SizedBox(height: 20.0,),
            TextField(
            controller: titleController,
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
                children: [
                  TextField(
                  controller: _textEditingController,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Note something down",
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                ]
              ),
            ),
            //Spacer(),
            Row(
              children: [
                NoteTypeButton(
                  onTap: (){

                  },
                  label: "Info",
                  color: Colors.green,
                  borderColor: Colors.green,
                ),
                SizedBox(width: 20.0,),
                NoteTypeButton(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return TodoPage();
                    }));
                  },
                  label: "Todo",
                  color: Colors.transparent,
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
