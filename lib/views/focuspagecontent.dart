import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FocusPageContent extends StatefulWidget {
  final String? noteId;
  final String? content;

  const FocusPageContent({super.key, this.noteId, this.content});

  @override
  State<FocusPageContent> createState() => _FocusPageContentState();
}

class _FocusPageContentState extends State<FocusPageContent> {
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
    return lines.asMap().entries.map((entry) {
      final index = entry.key + 1;
      final line = entry.value;

      // Eğer satır boşsa olduğu gibi bırak
      if (line.isEmpty) return line;

      // Satır bir sayı ile başlıyorsa, sadece numaralandır ve boşluk ekle
      if (RegExp(r'^\d+|\*').hasMatch(line)) {
        return line;
      } else {
        // Satır bir sayı ile başlamıyorsa başına * koy ve numaralandır
        return '$index) $line\n\n\n\n\n\n';
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
                  maxLines: 25,
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
                      // Note güncellenmesi
                      await dbRef.child(widget.noteId!).update(notes);
                    } else {
                      // Yeni note eklenmesi
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
