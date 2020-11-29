import 'package:flutter/material.dart';
class DrawerModel{
  IconData icon;
  String title;
  IconButton switchButton;

  DrawerModel({this.icon, this.title, this.switchButton});
}

List<DrawerModel> drawerItems = [
  DrawerModel(icon: Icons.bookmark_border, title: "All Notes"),
  DrawerModel(icon: Icons.notifications_none, title: "Reminders"),
  DrawerModel(icon: Icons.label_outline, title: "Labels"),
  DrawerModel(icon: Icons.archive_outlined, title: "Archives"),
  DrawerModel(icon: Icons.delete, title: "Trash"),
  DrawerModel(icon: Icons.settings, title: "Settings"),
  DrawerModel(icon: Icons.help_outline, title: "Help centre"),
];