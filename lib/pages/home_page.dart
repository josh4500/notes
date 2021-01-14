import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/pages/add_note_page.dart';
import 'package:notes/services/db_service.dart';
import 'package:notes/styles/constant_colors.dart';
import 'package:notes/widgets/app_drawer.dart';
import 'package:notes/widgets/bottom_navigation.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DbService dbService = DbService();
  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final primColor = Theme.of(context).primaryColor;
    return Scaffold(
      //backgroundColor: kBackgroundDark,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            List<Map<String, bool>> todo;
            return AddNote(
                Note(title: "", description: "", date: "", todo: todo));
          }));
        },
        child: Icon(
          Icons.add,
          color: primColor,
        ),
      ),
      key: _scaffoldKey,
      drawer: AppDrawer(),
      body: Container(
        //margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _openDrawer();
                  },
                  child: Icon(Icons.menu),
                ),
                CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/IMG_20201126_162234_571~2.jpg"),
                )
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "My Notes",
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 48.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
                color: Theme.of(context).backgroundColor,
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: primColor,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: primColor,
                  ),
                  hintText: "Search from notes...",
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.keyboard_voice,
                      color: primColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: FutureBuilder(
                future: dbService.getNotes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Note> note = snapshot.data;
                    return ListView.builder(
                      itemCount: note.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(note[index].title),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
