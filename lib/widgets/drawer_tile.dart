import 'package:flutter/material.dart';
import 'package:notes/models/drawer_model.dart';
class DrawerTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final Function onTap;
  final Color color;

  DrawerTile({Key key, this.icon, this.label, this.onTap, this.color}) : super(key: key);
  @override
  _DrawerTileState createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {

  @override
  Widget build(BuildContext context) {
    var _textStyle = Theme.of(context).textTheme.bodyText1;
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 210.0,
        height: 50.0,
        margin: EdgeInsets.only(right: 30.0),
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: Row(
          children: [
            Icon(widget.icon,),
            SizedBox(width: 10.0,),
            Text(widget.label, style: _textStyle),
          ],
        ),
      ),
    );
  }
}
