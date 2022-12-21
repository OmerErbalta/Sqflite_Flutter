// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myapp/utils/databaseHelper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var db = DatabaseHelper();
    db.callTable();

    return MaterialApp(
      title: "ExampleSqflite",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: Sqflite(),
    );
  }
}

class Sqflite extends StatelessWidget {
  Sqflite({super.key});
  DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
