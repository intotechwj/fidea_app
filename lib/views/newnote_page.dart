import 'package:flutter/material.dart';
import 'package:fidea_app/views/control_page.dart';
import 'package:fidea_app/views/plan_page.dart';
import 'package:fidea_app/views/start_page.dart';
import 'package:fidea_app/views/focus_page.dart';
import 'package:fidea_app/views/widgets/appbar_widget.dart';

class NewnotePage extends StatelessWidget {
  final String? noteId;
  final String? content;
  final String pageType; // Page type parameter to determine which page to show

  const NewnotePage({
    super.key,
    this.noteId,
    this.content,
    required this.pageType,
  });

  @override
  Widget build(BuildContext context) {
    Widget page;

    switch (pageType) {
      case 'Focus':
        page = FocusPage(noteId: noteId, content: content);
        break;
      case 'Control':
        page = ControlPage(noteId: noteId, content: content);
        break;
      case 'Plan':
        page = PlanPage(noteId: noteId, content: content);
        break;
      case 'Start':
        page = StartPage(noteId: noteId);
        break;
      default:
        page = const Center(child: Text('Unknown Page Type'));
    }

    return Scaffold(
      appBar: MyAppBar(
        title: '$pageType Page', // Update the title based on pageType
        backButton: BackButton(onPressed: Navigator.of(context).pop),
      ),
      body: page,
    );
  }
}
