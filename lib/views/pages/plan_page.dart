import 'package:fidea_app/bloc/cubit/note_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fidea_app/controller/general_controller.dart';
import 'package:fidea_app/views/widgets/notesave_widget.dart';

class PlanPage extends StatelessWidget {
  final String? noteId;
  final String? content;

  const PlanPage({super.key, this.noteId, this.content});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit(),
      child: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          final controller = GeneralController();

          TextEditingController noteController = controller.createNoteController(content);

          return Scaffold(
            body: NoteSaveWidget(
              noteController: noteController,
              controller: controller,
              noteId: noteId,
              formatFunction: controller.formatNotesForPlanPage,
            ),
          );
        },
      ),
    );
  }
}
