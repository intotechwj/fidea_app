import 'package:fidea_app/controller/general_controller.dart';
import 'package:flutter/material.dart';

class NoteView extends StatelessWidget {
  final String? noteId;
  final int plusCount;
  final int minusCount;

  const NoteView({
    super.key,
    this.noteId,
    required this.plusCount,
    required this.minusCount,
  });

  @override
  Widget build(BuildContext context) {
    final generalController = GeneralController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Not Görüntüle'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                '${((plusCount / (plusCount + minusCount)) * 100).toStringAsFixed(1)}% Bitti',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<String>(
          future: generalController.fetchNoteContent(noteId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            }

            final notes = snapshot.data ?? '';
            final formattedNotes = generalController.formatNotesForDisplay(notes);

            return SingleChildScrollView(
              child: RichText(
                text: TextSpan(
                  children: formattedNotes,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
