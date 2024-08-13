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
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
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
