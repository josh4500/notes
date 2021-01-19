import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/widgets/note_type.dart';

class TodoTile extends StatelessWidget {
  final String title;
  final List<Map<String, bool>> todo;
  final int numOfTodo;
  final String date;

  const TodoTile({this.title, this.todo, this.numOfTodo, this.date});
  @override
  Widget build(BuildContext context) {
    return Container(
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
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: todo.length ?? 0,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: todo[index].values.toList()[0],
                      onChanged: (val) {},
                    ),
                    Text(
                      todo[index].keys.toList()[0],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                );
              },
            ),
          ),
          Spacer(),
          NoteType(
            label: "Todo",
            date: this.date,
          ),
        ],
      ),
    );
  }
}
