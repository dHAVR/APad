import 'package:apad/models/note.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  final List<Note> currentNotes = [];

  // Create a new note
  Future<void> addNote(String text) async {
    final note = Note()
      ..text = text;
    await isar.writeTxn(() => isar.notes.put(note));
    fetchNotes();
  }

  // Fetch notes
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  // Update a note
  Future<void> updateNote(int id, String updatedText) async {
    final currentNote = await isar.notes.get(id);
    if (currentNote != null) {
      currentNote.text = updatedText;
      await isar.writeTxn(() => isar.notes.put(currentNote));
      await fetchNotes();
    }
  }

  // Delete a note
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
