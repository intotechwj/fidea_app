import 'package:fidea_app/model/note_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GeneralController {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('notes');

  TextEditingController createNoteController(String? content) {
    return TextEditingController(text: content);
  }

  String formatNotesForFocusPage(String notes) {
    final lines = notes.split('\n');
    return lines.asMap().entries.map((entry) {
      final index = entry.key + 1;
      final line = entry.value;

      if (line.isEmpty) return line;

      if (RegExp(r'^\d+|\*|[+-]').hasMatch(line)) {
        return line;
      } else {
        return '$index) $line\n\n\n';
      }
    }).join('\n');
  }

String formatNotesForControlPage(String notes) {
  final lines = notes.split('\n');
  return lines.map((line) {
    if (line.isEmpty) return line; // Boş satırları olduğu gibi bırak
    if (RegExp(r'^\d+|\*|[+-]').hasMatch(line)) {
      // Satır başında sayı, * veya +,- varsa satırı olduğu gibi döndür
      return line;
    } else {
      // Diğer satırları * ile başlat
      return '* $line';
    }
  }).join('\n');
}

    String formatNotesForPlanPage(String notes) {
    final lines = notes.split('\n');
    return lines.map((line) {
      if (line.isEmpty) return line; 
      if (RegExp(r'^\d+|\*|[+-]').hasMatch(line)) {
        // Satır bir sayı ile başlıyorsa
        return line;
      } else {
        return '- $line';
      }
    }).join('\n');
  }


  Future<void> saveNote({
    required String? noteId,
    required TextEditingController noteController,
    required BuildContext context,
    required String Function(String) formatFunction,
  }) async {
    try {
      final formattedNotes = formatFunction(noteController.text);

      Note note = Note(
        id: noteId ?? dbRef.push().key!,
        content: formattedNotes,
      );

      if (noteId != null) {
        await dbRef.child(noteId).update(note.toMap());
      } else {
        await dbRef.push().set(note.toMap());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Realtime Database\'e not kaydedildi')),
      );

      noteController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Realtime Database hatası: $e')),
      );
    }
  }
}
