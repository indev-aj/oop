import 'package:flutter/material.dart';
import 'package:mini_project/src/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String title = 'Mini Project OOP';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
       title: title,
       home: Scaffold(
         appBar: AppBar(
           title: Text(title),
         ),
         body: MainPage(), // call the MainPage class
       ),
    );
  }
}