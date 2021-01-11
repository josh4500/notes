import 'package:flutter/material.dart';
import 'package:notes/pages/home_page.dart';
import 'package:notes/styles/app_theme.dart';
import 'package:notes/utils/theme_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> ThemeNotifier()),
      ],
      child: MatApp(),
    );
  }
}

class MatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.dark(),
      home: HomePage(),
    );
  }
}

