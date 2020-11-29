import 'package:flutter/material.dart';

//DarkTheme colors
final  kBackgroundDark = _getColorFromHex("#171C26");

final kDrawerDark = _getColorFromHex("#283040");

final kFloatingButtonDark = _getColorFromHex("#3369FF");

final kYellowTileDark = _getColorFromHex("#FEB52B");

//lightTheme colors
final kBackgroundLight = _getColorFromHex("#FFFFFF");

final kDrawerLight = _getColorFromHex("#F6F6F6");

final kFloatingButtonLight = _getColorFromHex("#3369FF");

final kYellowTileLight = _getColorFromHex("#FEE160");

final kBottomNavLight = _getColorFromHex("#A6BDFF");



// ignore: missing_return
Color _getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }
}