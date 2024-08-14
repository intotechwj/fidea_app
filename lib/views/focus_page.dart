import 'package:fidea_app/controller/general_controller.dart';
import 'package:fidea_app/views/widgets/notesave_widget.dart';
import 'package:flutter/material.dart';


class FocusPage extends StatefulWidget {
  final String? noteId;
  final String? content;

  const FocusPage({super.key, this.noteId, this.content});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  late TextEditingController _noteController;
  final GeneralController _controller = GeneralController();

  @override
  void initState() {
    super.initState();
    _noteController = _controller.createNoteController(widget.content);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NoteSaveWidget(noteController: _noteController, controller: _controller, noteId: widget.noteId, formatFunction: _controller.formatNotesForFocusPage);
  }
}


