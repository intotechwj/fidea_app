import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fidea_app/views/newnote_page.dart';
import 'package:fidea_app/views/noteview_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../model/note_model.dart';

part '../state/note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  void fetchNotes() {
    emit(NoteLoading());
    FirebaseDatabase.instance.ref('notes').onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        final notes = data.entries.map((entry) {
          return NoteModel.fromMap(entry.value, entry.key);
        }).toList();
        emit(NoteLoaded(notes));
      } else {
        emit(NoteEmpty());
      }
    }).onError((error) {
      emit(NoteError('Hata: $error'));
    });
  }

  void showNoteOptions(BuildContext context, String noteId, String content) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.visibility),
              title: const Text('Gör'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                showViewOptions(context, noteId, content);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Düzenle'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                showEditOptions(context, noteId, content);
              },
            ),
          ],
        );
      },
    );
  }

  void showViewOptions(BuildContext context, String noteId, String content) {
    final plusCount = countLinesStartingWith(content, '+');
    final minusCount = countLinesStartingWith(content, '-');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteView(
          noteId: noteId,
          plusCount: plusCount,
          minusCount: minusCount,
        ),
      ),
    );
  }

  void showEditOptions(BuildContext context, String noteId, String content) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.center_focus_strong_outlined),
              title: const Text('Focus Düzenle'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewnotePage(
                      noteId: noteId,
                      content: content,
                      pageType: 'Focus',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.control_point_duplicate_outlined),
              title: const Text('Control Düzenle'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewnotePage(
                      noteId: noteId,
                      content: content,
                      pageType: 'Control',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.featured_play_list_outlined),
              title: const Text('Plan Düzenle'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewnotePage(
                      noteId: noteId,
                      content: content,
                      pageType: 'Plan',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.start_outlined),
              title: const Text('Start Düzenle'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewnotePage(
                      noteId: noteId,
                      content: content,
                      pageType: 'Start',
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  int countLinesStartingWith(String content, String prefix) {
    return content.split('\n').where((line) => line.startsWith(prefix)).length;
  }
}
