// ignore_for_file: use_build_context_synchronously

import 'package:fidea_app/service/database_service.dart';
import 'package:fidea_app/text/apptext.dart';
import 'package:fidea_app/views/utility/note_formatter.dart';
import 'package:flutter/material.dart';

class GeneralController {
  final DatabaseService databaseService;
  final NoteFormatter noteFormatter;

  GeneralController({
    DatabaseService? dbService,
    NoteFormatter? formatter,
  })  : databaseService = dbService ?? DatabaseService(),
        noteFormatter = formatter ?? NoteFormatter();

  TextEditingController createNoteController(String? content) {
    return TextEditingController(text: content);
  }

  Future<String> fetchNoteContent(String? noteId) async {
    return databaseService.fetchNoteContent(noteId);
  }

  List<TextSpan> formatNotesForDisplay(String notes) {
    return noteFormatter.formatForDisplay(notes);
  }

  String formatNotesForFocusPage(String notes) {
    return noteFormatter.formatForFocusPage(notes);
  }

  String formatNotesForControlPage(String notes) {
    return noteFormatter.formatForControlPage(notes);
  }

  String formatNotesForPlanPage(String notes) {
    return noteFormatter.formatForPlanPage(notes);
  }

  Future<void> saveNote({
    required String? noteId,
    required TextEditingController noteController,
    required BuildContext context,
    required String Function(String) formatFunction,
  }) async {
    try {
      final formattedNotes = formatFunction(noteController.text);

      if (noteId != null) {
        await databaseService.saveNoteContent(noteId, formattedNotes);
      } else {
        final newNoteId = databaseService.dbRef.push().key!;
        await databaseService.saveNoteContent(newNoteId, formattedNotes);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AlertSnackDialog.saveRealtimeDB)),
      );

      noteController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${ErrorMessages.realtimeDBError}: $e')),
      );
    }
  }
}
