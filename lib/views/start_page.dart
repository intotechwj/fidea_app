import 'package:fidea_app/views/noteview_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  final String? noteId;

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
        _isChecked = List.generate(_lines.length, (index) {
          return RegExp(r'^\+').hasMatch(_lines[index]);
        });
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

  String formatNotesForStartPage() {
    final formattedLines = _lines.asMap().entries.map((entry) {
      final index = entry.key;
      final line = entry.value;

      if (line.isEmpty) return line;
      if (RegExp(r'^[+-]').hasMatch(line)) {
        return (_isChecked[index] ? '+ ' : '-') + line.substring(1).trim();
      } else {
        return line;
      }
    }).join('\n');
    return formattedLines;
  }

  int countPlusLines() {
    return _lines.where((line) => line.startsWith('+')).length;
  }

  int countMinusLines() {
    return _lines.where((line) => line.startsWith('-')).length;
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

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _lines.length,
                    itemBuilder: (context, index) {
                      final line = _lines[index];
                      final showCheckbox = RegExp(r'^[+-]').hasMatch(line);

                      return showCheckbox
                          ? CheckboxListTile(
                              title: Text(line.substring(1).trim()),
                              value: _isChecked[index],
                              onChanged: (bool? value) {
                                if (value != null) {
                                  _updateCheckbox(index, value);
                                }
                              },
                            )
                          : ListTile(title: Text(line));
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final newFormattedNotes = formatNotesForStartPage();
                      final ref = FirebaseDatabase.instance.ref('notes/${widget.noteId}');
                      await ref.update({'NOTE': newFormattedNotes});
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteView(
                          noteId: widget.noteId!,
                          plusCount: countPlusLines(),
                          minusCount: countMinusLines(),
                        ),
                      ),
                    );
                  },
                  child: const Text('Notu Görüntüle'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
