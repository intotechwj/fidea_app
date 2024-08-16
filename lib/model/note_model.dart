import 'package:fidea_app/text/apptext.dart';

class NoteModel {
  final String id;
  final String content;

  NoteModel({required this.id, required this.content});

  factory NoteModel.fromMap(Map<dynamic, dynamic> data, String id) {
    return NoteModel(
      id: id,
      content: data[DBCollections.noteValue] ?? '',
    );
  }
}
class Note {
  final String? id;
  final String content;

  Note({
    this.id,
    required this.content,
  });

  Map<String, String> toMap() {
    return {
      DBCollections.noteValue: content,
    };
  }
}
