import 'package:flutter/material.dart';
class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var defaultIconColor = Theme.of(context).iconTheme.color;
    var selectedIconColor = Theme.of(context).floatingActionButtonTheme.backgroundColor;
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 80.0,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, 80.0),
            painter: BNBCustomPainter(context),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
              child: Icon(Icons.add, color: Theme.of(context).accentColor,),
              onPressed: (){

              },
            ),
          ),
          Container(
            width: size.width,
            height: 80.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.launch, size: 30.0,),
                  color: currentIndex == 0 ? selectedIconColor : defaultIconColor,
                  onPressed: (){
                    setBottomBarIndex(0);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.picture_in_picture_outlined, size: 30.0),
                  color: currentIndex == 1 ? selectedIconColor : defaultIconColor,
                  onPressed: (){
                    setBottomBarIndex(1);
                  },
                ),
                Container(width: size.width*0.2,),
                IconButton(
                  icon: Icon(Icons.keyboard_voice_outlined, size: 30.0),
                  color: currentIndex == 2 ? selectedIconColor : defaultIconColor,
                  onPressed: (){
                    setBottomBarIndex(2);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.label_outline, size: 30.0),
                  color: currentIndex == 3 ? selectedIconColor : defaultIconColor,
                  onPressed: (){
                    setBottomBarIndex(3);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  final BuildContext context;

  BNBCustomPainter(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Theme.of(context).bottomNavigationBarTheme.backgroundColor
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20), radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 30, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
