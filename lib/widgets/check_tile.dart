import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
class CheckTile extends StatefulWidget {
  bool isChecked;
  List<Widget> listType;
  Widget widgetType;

  CheckTile({Key key, this.isChecked = false, this.widgetType, this.listType}) : super(key: key);
  @override
  _CheckTileState createState() => _CheckTileState();
}

class _CheckTileState extends State<CheckTile> {
  bool isChecked;

  _CheckTileState({this.isChecked});
  @override
  Widget build(BuildContext context) {
    bool checked = false;
    return Row(
      children: [
        CircularCheckBox(
          inactiveColor: Colors.white,
          disabledColor: Colors.transparent,
          checkColor: Colors.green,
          value: checked,
          onChanged: (value){
            setState(() {
              checked = !checked;
            });
          },
        ),
        SizedBox(width: 10.0,),
        Expanded(
          child: TextField(
            onSubmitted: (value){
              //widget.listType.add(widget.widgetType);
            },
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );;
  }
}
