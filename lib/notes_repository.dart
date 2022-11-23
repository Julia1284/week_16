import 'package:week_16/note.dart';
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
    await _box.putAsync(note);
  }

  Future deleteNote(int id) async {
    _box.remove(id);
  }

  updateNote(Note note, newname, newdescription) {
    note.name = newname;
    note.description = newdescription;
    _box.put(note);
  }
}
