import 'package:flutter/material.dart';
import 'package:week_16/note.dart';
import 'package:week_16/notes_repository.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _notesRepo = NotesRepository();
  late var _notes = <Note>[];

  @override
  void initState() {
    super.initState();
    _notesRepo
        .initDB()
        .whenComplete(() => setState(() => _notes = _notesRepo.notes));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (_, i) => ListTile(
          title: Text(
            _notes[i].name,
          ),
          subtitle: Text(
            _notes[i].description,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  icon: Icon(Icons.edit), onPressed: () => _showDialogEdit(i)),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _notesRepo.deleteNote(_notes[i].id);
                  setState(() {
                    _notes = _notesRepo.notes;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future _showDialog() => showGeneralDialog(
        context: context,
        barrierDismissible: false,
        pageBuilder: (_, __, ___) {
          final nameController = TextEditingController();
          final descController = TextEditingController();
          return AlertDialog(
            title: const Text('New note'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(hintText: 'Description'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await _notesRepo.addNote(
                    Note(
                      name: nameController.text,
                      description: descController.text,
                    ),
                  );
                  setState(() {
                    _notes = _notesRepo.notes;
                    Navigator.pop(context);
                  });
                  print(_notes);
                },
                child: const Text('Add'),
              )
            ],
          );
        },
      );
  Future _showDialogEdit(i) => showGeneralDialog(
        context: context,
        barrierDismissible: false,
        pageBuilder: (_, __, ___) {
          String newName = _notes[i].name;
          String newDescription = _notes[i].description;
          return AlertDialog(
            title: const Text('Edit note'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: _notes[i].name,
                  decoration: const InputDecoration(hintText: 'Name'),
                  onChanged: (name) => setState(() {
                    newName = name;
                  }),
                ),
                TextFormField(
                  initialValue: _notes[i].description,
                  // controller: descController,
                  decoration: const InputDecoration(hintText: 'Description'),
                  onChanged: (desc) => setState(() {
                    newDescription = desc;
                  }),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _notesRepo.updateNote(_notes[i], newName, newDescription);
                  setState(() {
                    _notes = _notesRepo.notes;
                    Navigator.pop(context);
                  });
                },
                child: const Text('Edit'),
              )
            ],
          );
        },
      );
}
