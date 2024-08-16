import 'package:flutter/material.dart';
import 'package:fidea_app/views/pages/control_page.dart';
import 'package:fidea_app/views/pages/plan_page.dart';
import 'package:fidea_app/views/pages/start_page.dart';
import 'package:fidea_app/views/pages/focus_page.dart';

class NewnotePage extends StatelessWidget {
  final String? noteId;
  final String? content;
  final String pageType;

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
        page = const Center(child: Text('Bilinmeyen Sayfa Türü'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('$pageType Sayfası'),
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
      ),
      body: page,
    );
  }
}
