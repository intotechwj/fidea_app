import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(height: 100,
            width: 100,
            child: Center(child: Text('drawer'))),
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
            FilledButton(onPressed: (){}, child: const Text('a')),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return const Card(
            shape: StadiumBorder(
            ),
            child:Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('not'),
            ),
          );
        },
      ),
    );
  }
}