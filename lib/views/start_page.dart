import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  final String? noteId; // Belirli notun ID'si

  const StartPage({super.key, this.noteId});

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late Future<String> _noteContent;
  late List<String> _lines;
  late List<bool> _isChecked;

  @override
  void initState() {
    super.initState();
    _noteContent = fetchNoteContent(widget.noteId);
    _lines = [];
    _isChecked = [];
  }

  Future<String> fetchNoteContent(String? noteId) async {
    if (noteId == null) return '';

    final ref = FirebaseDatabase.instance.ref('notes/$noteId');
    final snapshot = await ref.get();
    final data = snapshot.value as Map<dynamic, dynamic>?;

    if (data != null) {
      final notes = data['NOTE'] as String;
      setState(() {
        _lines = notes.split('\n');
        _isChecked = List.generate(_lines.length, (index) => false);
      });
      return notes;
    } else {
      return '';
    }
  }

  void _updateCheckbox(int index, bool value) {
    setState(() {
      _isChecked[index] = value;
    });
  }

  String formatNotes() {
    final formattedLines = _lines.asMap().entries.map((entry) {
      final index = entry.key;
      final line = entry.value;

      if (line.isEmpty) return line; // Boş satırları olduğu gibi bırak
      if (RegExp(r'^[a-zA-Z]').hasMatch(line)) {
        // Satır bir harfle başlıyorsa, checkbox ekle
        return (_isChecked[index] ? '+ ' : '') + line;
      } else {
        // Diğer satırlar olduğu gibi bırak
        return line;
      }
    }).join('\n');

    return formattedLines;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<String>(
          future: _noteContent,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            }

            final notes = snapshot.data ?? '';

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _lines.length,
                    itemBuilder: (context, index) {
                      final line = _lines[index];
                      final showCheckbox = line.isNotEmpty && RegExp(r'^[a-zA-Z]').hasMatch(line);

                      return showCheckbox
                          ? CheckboxListTile(
                        title: Text(line),
                        value: _isChecked[index],
                        onChanged: (bool? value) {
                          if (value != null) {
                            _updateCheckbox(index, value);
                          }
                        },
                      )
                          : ListTile(title: Text(line)); // Checkbox gösterilmeden satırı göster
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final newFormattedNotes = formatNotes();

                      Map<String, String> notesMap = {
                        'NOTE': newFormattedNotes,
                      };

                      final ref = FirebaseDatabase.instance.ref('notes/${widget.noteId}');
                      await ref.update(notesMap);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Not güncellendi')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Hata: $e')),
                      );
                    }
                  },
                  child: const Text('Güncelle'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
