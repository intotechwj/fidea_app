import 'package:fidea_app/model/note_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GeneralController {
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child('notes');

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
        return '$index) $line\n';
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

    List<TextSpan> formatNotesForDisplay(String notes) {
    final lines = notes.split('\n');
    final spans = <TextSpan>[];

    for (var line in lines) {
      if (line.isEmpty) continue;

      if (RegExp(r'^\d+').hasMatch(line)) {
        // Sayı ile başlayan başlıklar
        spans.add(
          TextSpan(
            text: '$line\n\n',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),
        );
      } else if (line.startsWith('*')) {
        // * ile başlayan başlıklar
        spans.add(
          TextSpan(
            text: '$line\n\n',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        );
      } else {
        // Diğer satırlar
        spans.add(
          TextSpan(
            text: '$line\n\n',
            style: const TextStyle(fontSize: 20), // Varsayılan font boyutu
          ),
        );
      }
    }

    return spans;
  }

  
}
