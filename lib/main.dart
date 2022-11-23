import 'package:flutter/material.dart';
import 'package:week_16/notes_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'NotePages',
      home: NotesPage(),
    );
  }
}
