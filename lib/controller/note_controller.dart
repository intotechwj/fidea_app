import 'package:fidea_app/views/noteview_page.dart'; // Import NoteViewPage
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fidea_app/model/note_model.dart';
import '../views/newnote_page.dart';

class NoteController {
  Stream<List<NoteModel>> fetchNotes() {
    return FirebaseDatabase.instance.ref('notes').onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        return data.entries.map((entry) {
          return NoteModel.fromMap(entry.value, entry.key);
        }).toList();
      } else {
        return [];
      }
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

  int countLinesStartingWith(String content, String prefix) {
    return content.split('\n').where((line) => line.startsWith(prefix)).length;
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
}
