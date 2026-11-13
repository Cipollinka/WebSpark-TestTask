import 'package:flutter/material.dart';
import 'package:test_task/home_page.dart';
import 'package:test_task/preview_screen.dart';
import 'package:test_task/process_page.dart';
import 'package:test_task/result_list_screen.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.blue,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    )
  ),
  routes: {
    '/': (BuildContext context) => HomePage(),
    '/process': (BuildContext context) => ProcessPage(),
    '/result': (BuildContext context) => ResultListScreen(),
    '/preview' : (BuildContext context) => PreviewScreen()
  },
  initialRoute: '/',
));