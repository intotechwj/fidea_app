import 'package:fidea_app/views/pages/introduction_page.dart';
import 'package:fidea_app/views/pages/settings_page.dart';
import 'package:fidea_app/text/apptext.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 100,
            width: 100,
            child: Center(child: Text(PagesFidea.fidea)),
          ),
          ListTile(
            leading: const Icon(Icons.help_center_outlined),
            title: const Text(PagesFidea.help),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const IntroductionPage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text(PagesFidea.settings),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
