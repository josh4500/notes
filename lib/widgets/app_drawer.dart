import 'package:flutter/material.dart';
import 'package:notes/models/drawer_model.dart';
import 'package:notes/styles/constant_colors.dart';
import 'package:notes/utils/theme_notifier.dart';
import 'package:notes/widgets/drawer_tile.dart';
import 'package:provider/provider.dart';
class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  bool _isSwitched = false;
  int currentIndexSelected = 0;
  setSelectedIndex(int index){
    setState(() {
      currentIndexSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).scaffoldBackgroundColor;
    return Container(
      width: 270.0,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      child: Column(
        children: [
          SizedBox(height: 25.0,),
          _userHeader(),
          SizedBox(height: 20.0,),
          Flexible(
            child: ListView(
              children: [
                DrawerTile(
                  icon: drawerItems[0].icon,
                  label: drawerItems[0].title,
                  onTap: (){
                    setSelectedIndex(0);
                  },
                  color: currentIndexSelected == 0 ? color : Colors.transparent,
                ),
                DrawerTile(
                  icon: drawerItems[1].icon,
                  label: drawerItems[1].title,
                  onTap: (){
                    setSelectedIndex(1);
                  },
                  color: currentIndexSelected == 1 ? color : Colors.transparent,
                ),
                DrawerTile(
                  icon: drawerItems[2].icon,
                  label: drawerItems[2].title,
                  onTap: (){
                    setSelectedIndex(2);
                  },
                  color: currentIndexSelected == 2 ? color : Colors.transparent,
                ),
                DrawerTile(
                  icon: drawerItems[3].icon,
                  label: drawerItems[3].title,
                  onTap: (){
                    setSelectedIndex(3);
                  },
                  color: currentIndexSelected == 3 ? color : Colors.transparent,
                ),
                DrawerTile(
                  icon: drawerItems[4].icon,
                  label: drawerItems[4].title,
                  onTap: (){
                    setSelectedIndex(4);
                  },
                  color: currentIndexSelected == 4 ? color : Colors.transparent,
                ),
                themeSwitch(color),
                DrawerTile(
                  icon: drawerItems[5].icon,
                  label: drawerItems[5].title,
                  onTap: (){
                    setSelectedIndex(6);
                  },
                  color: currentIndexSelected == 6 ? color : Colors.transparent,
                ),
                DrawerTile(
                  icon: drawerItems[6].icon,
                  label: drawerItems[6].title,
                  onTap: (){
                    setSelectedIndex(7);
                  },
                  color: currentIndexSelected == 7 ? color : Colors.transparent,
                ),
              ],
            )
          ),

        ],
      ),

    );
  }

  Container _userHeader(){
    return Container(
      height: 50.0,
      width: 210.0,
      padding: EdgeInsets.fromLTRB(14.0, 10.0, 0.0, 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        )
      ),
      child: Row(
        children: [
          CircleAvatar(
            //backgroundColor: Colors.green,
            backgroundImage: AssetImage("assets/images/IMG_20201126_162234_571~2.jpg"),
          ),
          SizedBox(width: 10.0,),
          Text("Majid\'s Note", style: Theme.of(context).textTheme.bodyText1)
        ],
      ),
    );
  }

  Widget themeSwitch(Color color){
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return InkWell(
      onTap: (){
        setSelectedIndex(5);
      },
      child: Container(
        width: 210.0,
        height: 50.0,
        margin: EdgeInsets.only(right: 30.0),
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
        decoration: BoxDecoration(
          color: currentIndexSelected == 5 ? color : Colors.transparent,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: Row(
          children: [
            Icon(themeNotifier.isDarkTheme ? Icons.wb_sunny : Icons.brightness_3, color: Theme.of(context).iconTheme.color,),
            SizedBox(width: 10.0,),
            Text(_isSwitched ? "Light" : "Dark", style: Theme.of(context).textTheme.bodyText1),
            SizedBox(width: 80.0,),
            Switch(
              value: themeNotifier.isDarkTheme,
              onChanged: (value){
                setSelectedIndex(5);
                themeNotifier.switchTheme(value);
              },
            )
          ],
        ),
      ),
    );
  }
}
