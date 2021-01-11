import 'package:flutter/material.dart';

class NoteTypeButton extends StatelessWidget {
  final Function onTap;
  final String label;
  final Color labelColor;
  final Color color;
  final Color borderColor;

  const NoteTypeButton(
      {Key key,
      this.onTap,
      this.label,
      this.labelColor,
      this.color,
      this.borderColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: 48.0,
      decoration: BoxDecoration(
        color: color == null ? Colors.white : color,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: borderColor == null ? Colors.white : borderColor,
        ),
      ),
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        onPressed: onTap,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
