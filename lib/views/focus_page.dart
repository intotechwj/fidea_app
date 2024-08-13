import 'package:flutter/material.dart';
import 'package:fidea_app/views/appbar_widget.dart';
import 'package:fidea_app/views/bottomnavbar_widget.dart';
import 'package:fidea_app/views/control_page.dart';
import 'package:fidea_app/views/plan_page.dart';
import 'package:fidea_app/views/start_page.dart';
import 'package:fidea_app/views/focuspagecontent.dart';

class FocusPage extends StatefulWidget {
  final String? noteId;
  final String? content;

  const FocusPage({super.key, this.noteId, this.content});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      FocusPageContent(noteId: widget.noteId, content: widget.content),
      ControlPage(noteId: widget.noteId, content: widget.content), // Pass the parameters
      PlanPage(noteId: widget.noteId, content: widget.content),
      StartPage(noteId: widget.noteId),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'title',
        backButton: BackButton(onPressed: Navigator.of(context).pop),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: MyBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
