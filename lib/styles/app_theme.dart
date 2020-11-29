import 'package:flutter/material.dart';
import 'package:notes/styles/constant_colors.dart';

class AppTheme{

  static ThemeData light(){
    return ThemeData(
      backgroundColor: kDrawerLight,
      scaffoldBackgroundColor: kBackgroundLight,
      appBarTheme: AppBarTheme(
        color: kBackgroundLight
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: kFloatingButtonLight,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: kBottomNavLight,
      ),
      tabBarTheme: TabBarTheme(
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.black,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      accentColor: Colors.black,
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        headline5: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      primaryColor: Colors.black,


    );
  }

  static ThemeData dark(){
    return ThemeData(
      backgroundColor: kDrawerDark,
      scaffoldBackgroundColor: kBackgroundDark,
      appBarTheme: AppBarTheme(
        color: kBackgroundDark,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: kFloatingButtonDark
        //foregroundColor: kFloatingButtonDark
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: kDrawerDark,
      ),
      tabBarTheme: TabBarTheme(
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.white,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
        )
        //indicator:
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      accentColor: Colors.white,
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        headline5: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      primaryColor: Colors.white,
    );
  }
}