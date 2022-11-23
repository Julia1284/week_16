import 'package:flutter/material.dart';
import 'package:week_16/note.dart';
import 'package:week_16/notes_repository.dart';
import 'package:week_16/objectbox.g.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({super.key});

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  final _notesRepo = NotesRepository();
  late var _notes = <Note>[];

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
