import 'package:flutter/material.dart';
import 'package:notes/widgets/note_type_button.dart';
class InfoTile extends StatelessWidget {
  final String title;
  final String infoText;
  final String date;

  const InfoTile({Key key, this.title, this.infoText, this.date}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.4,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.subtitle2,),
          SizedBox(height: 7.0,),
          Text(infoText, style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.normal),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NoteTypeButton(
                onTap: (){

                },
                color: Colors.transparent,
                borderColor: Colors.white,
                label: "Info",
                labelColor: Colors.white,
              ),
              Text(date),
            ],
          )
        ],
      ),
    );
  }
}
