// ignore_for_file: use_build_context_synchronously
import 'package:fidea_app/text/apptext.dart';
import 'package:flutter/material.dart';
import 'package:fidea_app/views/utility/note_formatter.dart';
import 'package:fidea_app/views/pages/noteview_page.dart';
import 'package:fidea_app/service/database_service.dart';

class StartPage extends StatefulWidget {
  final String? noteId;

  const StartPage({super.key, this.noteId});

  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  late Future<String> _noteContent;
  late List<String> _lines;
  late List<bool> _isChecked;

  final DatabaseService _databaseService = DatabaseService();
  final NoteFormatter _noteFormatter = NoteFormatter();

  @override
  void initState() {
    super.initState();
    _noteContent = _fetchNoteContent(widget.noteId);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: futureBuilderStartPage(),
      ),
    );
  }


  

  FutureBuilder<String> futureBuilderStartPage() {
    return FutureBuilder<String>(
        future: _noteContent,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('${ErrorMessages.error}: ${snapshot.error}'));
          }

          if (!snapshot.hasData || _lines.isEmpty) {
            return const Center(child: Text(ErrorMessages.notFound));
          }

          return Column(
            children: [
              Expanded(
                child: listViewBuilderStartPage(),
              ),
              ElevatedButton(
                onPressed: _updateNoteContent,
                child: const Text(TextCRUD.update),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteView(
                        noteId: widget.noteId!,
                        plusCount: _lines.where((line) => line.startsWith('+')).length,
                        minusCount: _lines.where((line) => line.startsWith('-')).length,
                      ),
                    ),
                  ).then((_) {
                    // Refresh the content on return
                    setState(() {
                      _noteContent = _fetchNoteContent(widget.noteId);
                    });
                  });
                },
                child: const Text(TextCRUD.view),
              ),
            ],
          );
        },
      );
  }

  ListView listViewBuilderStartPage() {
    return ListView.builder(
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
              );
  }

    Future<String> _fetchNoteContent(String? noteId) async {
    final content = await _databaseService.fetchNoteContent(noteId);
    _lines = content.split('\n');
    _isChecked = List.generate(_lines.length, (index) {
      return RegExp(r'^\+').hasMatch(_lines[index]);
    });
    return content;
  }

  void _updateCheckbox(int index, bool value) {
    setState(() {
      _isChecked[index] = value;
    });
  }

  String _formatNotesForStartPage() {
    return _noteFormatter.formatForStartPage(_lines, _isChecked);
  }

  Future<void> _updateNoteContent() async {
    try {
      final newFormattedNotes = _formatNotesForStartPage();
      await _databaseService.saveNoteContent(widget.noteId!, newFormattedNotes);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AlertSnackDialog.updateNote)),
      );
      // Refresh the note content after update
      setState(() {
        _noteContent = _fetchNoteContent(widget.noteId);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${ErrorMessages.error}: $e')),
      );
    }
  }
}
