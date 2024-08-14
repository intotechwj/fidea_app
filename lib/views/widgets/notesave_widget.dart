import 'package:fidea_app/controller/general_controller.dart';
import 'package:flutter/material.dart';

class NoteSaveWidget extends StatelessWidget {
  const NoteSaveWidget({
    super.key,
    required this.noteController,
    required this.controller,
    required this.noteId,
    required this.formatFunction,
  });

  final TextEditingController noteController;
  final GeneralController controller;
  final String? noteId;
  final String Function(String) formatFunction;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: noteController,
                  maxLines: 25,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Buraya yazın...',
                  ),
                  //keyboardType: TextInputType.multiline,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.saveNote(
                    noteId: noteId,
                    noteController: noteController,
                    context: context,
                    formatFunction: formatFunction,
                  );
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
