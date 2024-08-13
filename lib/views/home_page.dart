import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fidea_app/views/appbar_widget.dart';
import 'package:fidea_app/views/drawer_widget.dart';
import 'package:fidea_app/views/focus_page.dart';
import 'package:fidea_app/views/note_view.dart'; // Not görünüm sayfasının yolu

import 'notecard_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Fidea',
      ),
      drawer: const MyDrawer(),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: SizedBox(
          width: 130,
          height: 40,
          child: FilledButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FocusPage(), // FocusPage'i aç
                ),
              );
            },
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Yeni not'),
                SizedBox(width: 8), // İkon ile metin arasındaki boşluk
                Icon(Icons.add),
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: FirebaseDatabase.instance.ref('notes').onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }

          final notes = <Map<String, dynamic>>[];

          if (snapshot.hasData) {
            final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

            if (data != null) {
              notes.addAll(data.entries.map((entry) {
                final note = entry.value as Map<dynamic, dynamic>;
                return {'id': entry.key, 'content': note['NOTE']};
              }));
            } else {
              return const Center(child: Text('Henüz not yok'),);
            }
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            padding: const EdgeInsets.all(8.0),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return GestureDetector(
                onTap: () {
                  _showNoteOptions(context, note['id'], note['content']);
                },
                child: NoteCard(
                  content: note['content'],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showNoteOptions(BuildContext context, String noteId, String content) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.visibility),
              title: const Text('Gör'),
              onTap: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteView(noteId: noteId),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Düzenle'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FocusPage(
                      noteId: noteId,
                      content: content,
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
