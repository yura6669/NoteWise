part of 'control_note_bloc.dart';

abstract class ControlNoteEvent extends Equatable {
  const ControlNoteEvent();

  @override
  List<Object?> get props => [];
}

class _AddNote extends ControlNoteEvent {
  final String userId;
  final String text;
  final File? image;

  const _AddNote({
    required this.userId,
    required this.text,
    this.image,
  });

  @override
  List<Object?> get props => [text, image];
}

class _UpdateNote extends ControlNoteEvent {
  final String text;
  final File? image;
  final String id;
  final String userId;

  const _UpdateNote({
    required this.text,
    this.image,
    required this.id,
    required this.userId,
  });

  @override
  List<Object?> get props => [text, image, id, userId];
}

class _DeleteNote extends ControlNoteEvent {
  final NoteModel note;
  final String userId;

  const _DeleteNote({
    required this.note,
    required this.userId,
  });

  @override
  List<Object?> get props => [note, userId];
}
