import 'package:flutter/material.dart';

class NoteType extends StatelessWidget {
  final String label;
  final String date;

  const NoteType({@required this.label, this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 27.0,
          width: 43.0,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: Center(
            child: Text(
              this.label,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Text(
          this.date.substring(0, 6),
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
