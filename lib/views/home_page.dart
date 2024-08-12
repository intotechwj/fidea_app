import 'package:fidea_app/views/appbar_widget.dart';
import 'package:fidea_app/views/drawer_widget.dart';
import 'package:fidea_app/views/focus_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'x',
      ),
      drawer: const MyDrawer(),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: SizedBox(
          width: 130, // Buton genişliği
          height: 40, // Buton yüksekliği
          child: FilledButton(
            onPressed: () {
              // Yeni not oluşturma işlemini başlat
            },
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 16)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Yeni not'),
                SizedBox(width: 8), // İkon ile metin arasındaki boşluk
                Icon(Icons.add),
              ],
            ),
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FocusPage()),
              );
            },
            child: Container(
              color: Colors.red,
              height: 100,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            color: Colors.amberAccent,
            height: 100,
          ),
        ],
      ),
    );
  }
}
