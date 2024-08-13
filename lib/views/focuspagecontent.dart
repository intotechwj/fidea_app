import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FocusPageContent extends StatefulWidget {
  const FocusPageContent({super.key});

  @override
  State<FocusPageContent> createState() => _FocusPageContentState();
}

class _FocusPageContentState extends State<FocusPageContent> {
  late DatabaseReference dbRef;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('notes');
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  // Madde başlığı ekleyen fonksiyon
  String formatNotes(String notes) {
    final lines = notes.split('\n');
    return lines.asMap().entries.map((entry) {
      final index = entry.key + 1;
      final line = entry.value;
      return '$index) $line';
    }).join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _noteController,
                  maxLines: 35,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Buraya yazın...',
                  ),
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Kullanıcının yazdığı metni madde başlıklarıyla biçimlendir
                    final formattedNotes = formatNotes(_noteController.text);
      
                    Map<String, String> notes = {
                      'NOTE': formattedNotes,
                    };
      
                    // Veriyi Realtime Database'e ekle
                    await dbRef.push().set(notes);
      
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Realtime Database\'e not kaydedildi')),
                    );
      
                    _noteController.clear();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Realtime Database hatası: $e')),
                    );
                  }
                },
                child: const Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
