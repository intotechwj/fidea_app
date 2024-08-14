import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String content;

  const NoteCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16), // İçerik yazı tipi boyutu
          ),
        ),
      ),
    );
  }
}
