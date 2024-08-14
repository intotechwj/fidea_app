import 'package:flutter/material.dart';

class MyBottomNavBar extends StatelessWidget {
  final int selectedIndex; // Seçili sayfa indeksini alır
  final ValueChanged<int> onItemTapped; // Tap işlevini alır

  const MyBottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.center_focus_strong_outlined),
          label: 'Focus',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.control_point_duplicate_outlined),
          label: 'Control',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.next_plan_outlined),
          label: 'Plan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.start_outlined),
          label: 'Start',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.blueGrey[900],
      onTap: onItemTapped,
      type: BottomNavigationBarType.shifting,
    );
  }
}
