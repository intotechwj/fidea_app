import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fidea_app/text/apptext.dart';
import 'package:fidea_app/views/pages/newnote_page.dart';
import 'package:fidea_app/views/pages/noteview_page.dart';
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
              title: const Text(TextCRUD.show),
              onTap: () {
                Navigator.pop(context); 
                showViewOptions(context, noteId, content);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(TextCRUD.setUp),
              onTap: () {
                Navigator.pop(context); 
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
              title: const Text('${PagesFidea.focus} ${TextCRUD.setUp}'),
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewnotePage(
                      noteId: noteId,
                      content: content,
                      pageType: PagesFidea.focus,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.control_point_duplicate_outlined),
              title: const Text('${PagesFidea.control} ${TextCRUD.setUp}'),
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewnotePage(
                      noteId: noteId,
                      content: content,
                      pageType: PagesFidea.control,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.featured_play_list_outlined),
              title: const Text('${PagesFidea.plan} ${TextCRUD.setUp}'),
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewnotePage(
                      noteId: noteId,
                      content: content,
                      pageType: PagesFidea.plan,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.start_outlined),
              title: const Text('${PagesFidea.start} ${TextCRUD.setUp}'),
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewnotePage(
                      noteId: noteId,
                      content: content,
                      pageType: PagesFidea.start,
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
