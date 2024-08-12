import 'package:fidea_app/views/appbar_widget.dart';
import 'package:fidea_app/views/bottomnavbar_widget.dart';
import 'package:fidea_app/views/control_page.dart';
import 'package:fidea_app/views/plan_page.dart';
import 'package:fidea_app/views/start_page.dart';
import 'package:flutter/material.dart';

class FocusPage extends StatefulWidget {
  const FocusPage({super.key});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  // Sayfaları tanımlar
  final List<Widget> _pages = [
    const FocusPageContent(), // FocusPage içeriği başka bir widget olarak tanımlandı
    const ControlPage(),
    const PlanPage(),
    const StartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Yeni'),
      bottomNavigationBar: MyBottomNavBar(pages: _pages), // Sayfaları geçiyoruz
    );
  }
}

class FocusPageContent extends StatelessWidget {
  const FocusPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.lime);
  }
}
