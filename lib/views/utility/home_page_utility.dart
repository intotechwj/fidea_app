import 'package:fidea_app/controller/note_controller.dart';
import 'package:fidea_app/model/note_model.dart';
import 'package:fidea_app/views/widgets/notecard_widget.dart';
import 'package:flutter/material.dart';

StreamBuilder<List<NoteModel>> noteStreamBuilder() {
  return StreamBuilder<List<NoteModel>>(
    stream: NoteController().fetchNotes(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return Center(child: Text('Hata: ${snapshot.error}'));
      }

      final notes = snapshot.data;

      if (notes == null || notes.isEmpty) {
        return const Center(child: Text('Henüz not yok'));
      }

      return gridViewBuilder(notes);
    },
  );
}

GridView gridViewBuilder(List<NoteModel> notes) {
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
          NoteController().showNoteOptions(context, note.id, note.content);
        },
        child: NoteCard(content: note.content),
      );
    },
  );
}
