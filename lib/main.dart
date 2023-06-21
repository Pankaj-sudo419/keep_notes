import 'package:flutter/material.dart';
import 'package:keep_note/screens/note_detail.dart';
//import 'package:keep_note/screens/note_detail.dart';
import 'package:keep_note/screens/note_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keep Note',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: NoteList(),
      //home:  NoteDetail(),
    );
  }
}
