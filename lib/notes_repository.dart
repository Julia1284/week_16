import 'package:week_16/note.dart';
import 'package:objectbox/objectbox.dart';
import 'package:week_16/objectbox.g.dart';

class NotesRepository {
  late final Store _store; // сущность, которая представляет всю базу данных
  late final Box<Note> _box; // сущность, которая представляет таблицу заметок

  List<Note> get notes =>
      _box.getAll(); // getAll - метод, который возвращает все записи таблицы

// что это непонятно!!!!!
  Future initDB() async {
    _store = await openStore();
    _box = _store.box<Note>();
  }

  Future addNote(Note note) async {
    print(note.id);
    print(note.name);
    await _box.putAsync(note);
  }

  Future deleteNote(int id) async {
    print(id);
    _box.remove(id);
  }

  Future deleteNote1(Note note) async {
    print(note.id);
    _box.remove(note.id);
  }

  Future updateNote(Note note, newname, newdescription) async {
    note.name = newname;
    note.description = newdescription;
    await _box.put(note);
  }
}
