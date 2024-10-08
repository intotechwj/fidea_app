import 'package:flutter/material.dart';
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Change Theme'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Log Out'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
