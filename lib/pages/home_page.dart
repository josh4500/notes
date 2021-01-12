import 'package:flutter/material.dart';
import 'package:notes/pages/add_note_page.dart';
import 'package:notes/styles/constant_colors.dart';
import 'package:notes/widgets/app_drawer.dart';
import 'package:notes/widgets/bottom_navigation.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage();
  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final primColor = Theme.of(context).primaryColor;
    return Scaffold(
      //backgroundColor: kBackgroundDark,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddNote();
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
          ],
        ),
      ),
    );
  }
}
