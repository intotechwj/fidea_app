import 'package:fidea_app/views/control_page.dart';
import 'package:fidea_app/views/focus_page.dart';
import 'package:fidea_app/views/plan_page.dart';
import 'package:fidea_app/views/start_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Tab sayısını burada belirtin
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          bottom: const TabBar(
            tabs: [
              Tab(
                  icon: Icon(Icons.center_focus_strong_outlined),
                  text: 'Tab 1'),
              Tab(icon: Icon(Icons.queue_play_next_outlined), text: 'Tab 2'),
              Tab(
                  icon: Icon(Icons.control_point_duplicate_outlined),
                  text: 'Tab 3'),
              Tab(icon: Icon(Icons.start_rounded), text: 'Tab 4'),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(
                height: 100,
                width: 100,
                child: Center(child: Text('drawer')),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              FilledButton(onPressed: () {}, child: const Text('a')),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // Her bir Tab için içeriği burada belirtin
            FocusPage(),
            PlanPage(),
            ControlPage(),
            StartPage(),
          ],
        ),
      ),
    );
  }
}
