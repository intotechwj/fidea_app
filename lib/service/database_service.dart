import 'package:fidea_app/text/apptext.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final DatabaseReference dbRef;

  DatabaseService({DatabaseReference? reference})
      : dbRef = reference ?? FirebaseDatabase.instance.ref().child(DBCollections.noteCollections);

  Future<String> fetchNoteContent(String? noteId) async {
    if (noteId == null) return '';

    final ref = dbRef.child(noteId);
    final snapshot = await ref.get();
    final data = snapshot.value as Map<dynamic, dynamic>?;

    if (data != null) {
      return data[DBCollections.noteValue] as String;
    } else {
      return '';
    }
  }

  Future<void> saveNoteContent(String noteId, String content) async {
    await dbRef.child(noteId).update({DBCollections.noteValue: content});
  }

  Future<void> updateFormattedNotes(String noteId, String formattedNotes) async {
    try {
      await saveNoteContent(noteId, formattedNotes);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCheckboxState(String noteId, List<String> lines, List<bool> isChecked) async {
    final formattedLines = lines.asMap().entries.map((entry) {
      final index = entry.key;
      final line = entry.value;

      if (line.isEmpty) return line;
      if (RegExp(r'^[+-]').hasMatch(line)) {
        return (isChecked[index] ? '+ ' : '-') + line.substring(1).trim();
      } else {
        return line;
      }
    }).join('\n');

    await saveNoteContent(noteId, formattedLines);
  }
}
