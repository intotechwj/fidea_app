import 'package:fidea_app/bloc/cubit/note_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../views/widgets/appbar_widget.dart';
import '../views/widgets/drawer_widget.dart';
import '../views/widgets/floatingactionbutton_widget.dart';
import '../views/widgets/notecard_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit()..fetchNotes(),
      child: Scaffold(
        appBar: const MyAppBar(title: 'Fidea'),
        drawer: const MyDrawer(),
        floatingActionButton: const CustomFloatingActionButtonWidget(),
        body: BlocBuilder<NoteCubit, NoteState>(
          builder: (context, state) {
            if (state is NoteLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is NoteError) {
              return Center(child: Text(state.message));
            }

            if (state is NoteEmpty) {
              return const Center(child: Text('Henüz not yok'));
            }

            if (state is NoteLoaded) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                padding: const EdgeInsets.all(8.0),
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  final note = state.notes[index];
                  return GestureDetector(
                    onTap: () {
                      context.read<NoteCubit>().showNoteOptions(context, note.id, note.content);
                    },
                    child: NoteCard(content: note.content),
                  );
                },
              );
            }

            return const Center(child: Text('Henüz not yok'));
          },
        ),
      ),
    );
  }
}
