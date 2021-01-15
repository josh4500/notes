import 'package:flutter/material.dart';
import 'package:notes/widgets/note_type_button.dart';

import 'note_type.dart';

class InfoTile extends StatelessWidget {
  final String title;
  final String infoText;
  final String date;

  const InfoTile({this.title, this.infoText, this.date});
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Text(
              this.title,
              style: TextStyle(
                  height: 2.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 19.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              this.infoText,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Spacer(),
            NoteType(
              label: "Info",
              date: this.date,
            ),
          ],
        ));
  }
}
