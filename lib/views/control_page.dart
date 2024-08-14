import 'package:fidea_app/views/widgets/notesave_widget.dart';
import 'package:flutter/material.dart';
import 'package:fidea_app/controller/general_controller.dart';

class ControlPage extends StatefulWidget {
  final String? noteId;
  final String? content;

  const ControlPage({super.key, this.noteId, this.content});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
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
    return NoteSaveWidget(noteController: _noteController, controller: _controller, noteId: widget.noteId, formatFunction: _controller.formatNotesForControlPage);
  }
}
