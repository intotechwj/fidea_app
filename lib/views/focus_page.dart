import 'package:flutter/material.dart';
import 'package:fidea_app/views/appbar_widget.dart';
import 'package:fidea_app/views/bottomnavbar_widget.dart';
import 'package:fidea_app/views/control_page.dart';
import 'package:fidea_app/views/plan_page.dart';
import 'package:fidea_app/views/start_page.dart';
import 'package:fidea_app/views/focuspagecontent.dart'; // Yeni dosyayı import edin

class FocusPage extends StatefulWidget {
  const FocusPage({super.key});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const FocusPageContent(),
    const ControlPage(),
    const PlanPage(),
    const StartPage(),
  ];

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
      body: _pages[_selectedIndex], // Seçilen sayfayı gösterir
      bottomNavigationBar: MyBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
