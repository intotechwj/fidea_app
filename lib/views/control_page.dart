import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ControlPage extends StatefulWidget {
  final String? noteId;
  final String? content;

  const ControlPage({super.key, this.noteId, this.content});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  late DatabaseReference dbRef;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('notes');
    _noteController = TextEditingController(text: widget.content);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  String formatNotes(String notes) {
    final lines = notes.split('\n');
    return lines.map((line) {
      if (line.isEmpty) return line; // Boş satırları olduğu gibi bırak
      if (RegExp(r'^\d+|\*').hasMatch(line)) {
        // Satır bir sayı ile başlıyorsa
        return line;
      } else {
        // Satır bir sayı ile başlamıyorsa başına * koy
        return '* $line\n';
      }
    }).join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _noteController,
                  maxLines: 25,                  //style: const TextStyle(fontSize: 18), // Same font size as FocusPageContent
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Buraya yazın...',
                  ),
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final formattedNotes = formatNotes(_noteController.text);

                    Map<String, String> notes = {
                      'NOTE': formattedNotes,
                    };

                    if (widget.noteId != null) {
                      // Update existing note
                      await dbRef.child(widget.noteId!).update(notes);
                    } else {
                      // Add new note
                      await dbRef.push().set(notes);
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Realtime Database\'e not kaydedildi')),
                    );

                    _noteController.clear();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Realtime Database hatası: $e')),
                    );
                  }
                },
                child: const Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
