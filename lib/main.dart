import 'package:flutter/material.dart';
import 'package:noteapp_ldb/screens/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Pal',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: HomeScreen()
    );
  }
}