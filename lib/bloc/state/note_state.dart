part of '../cubit/note_cubit.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object?> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final List<NoteModel> notes;

  const NoteLoaded(this.notes);

  @override
  List<Object?> get props => [notes];
}

class SingleNoteLoaded extends NoteState {
  final NoteModel note;

  const SingleNoteLoaded(this.note);

  @override
  List<Object?> get props => [note];
}

class NoteUpdated extends NoteState {
  final String message;

   const NoteUpdated(this.message);

  @override
  List<Object?> get props => [message];
}

class NoteEmpty extends NoteState {}

class NoteError extends NoteState {
  final String message;

  const NoteError(this.message);

  @override
  List<Object?> get props => [message];
}
