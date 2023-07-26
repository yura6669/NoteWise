import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/core/models/note.dart';
import 'package:notewise/core/repositories/notes_repository.dart';
import 'package:notewise/modules/resorses/internet.dart';

part 'control_note_event.dart';
part 'control_note_state.dart';

extension ControlNoteBlocX on ControlNoteBloc {
  void addNote({
    required String userId,
    required String text,
    File? image,
  }) {
    add(
      _AddNote(
        userId: userId,
        text: text,
        image: image,
      ),
    );
  }

  void updateNote({
    required String text,
    File? image,
    required String id,
    required String userId,
  }) {
    add(
      _UpdateNote(
        text: text,
        image: image,
        id: id,
        userId: userId,
      ),
    );
  }

  void deleteNote({
    required NoteModel note,
    required String userId,
  }) {
    add(
      _DeleteNote(
        note: note,
        userId: userId,
      ),
    );
  }
}

class ControlNoteBloc extends Bloc<ControlNoteEvent, ControlNoteState> {
  ControlNoteBloc({
    required this.notesRepository,
  }) : super(const _Initial()) {
    on<_AddNote>(_onAddNote);
    on<_UpdateNote>(_onUpdateNote);
    on<_DeleteNote>(_onDeleteNote);
  }

  final INotesRepository notesRepository;

  void _onAddNote(_AddNote event, Emitter<ControlNoteState> emit) async {
    emit(const _Loading());
    try {
      if (!await hasNetwork()) {
        emit(const _NoInternet());
      }

      late String? imageUrl;

      if (event.image != null) {
        imageUrl = await notesRepository.photoUrlWithStorage(
          photoFile: event.image!,
          userId: event.userId,
        );
      } else {
        imageUrl = null;
      }

      await notesRepository.addNote(
        text: event.text,
        image: imageUrl,
        userId: event.userId,
      );

      emit(const _SuccessAddNote());
    } on FirebaseException catch (e) {
      emit(_Error(message: e.toString()));
    } catch (e) {
      emit(_Error(message: e.toString()));
    }
  }

  void _onUpdateNote(_UpdateNote event, Emitter<ControlNoteState> emit) async {
    emit(const _Loading());
    try {
      if (!await hasNetwork()) {
        emit(const _NoInternet());
      }

      late String? imageUrl;

      if (event.image != null) {
        imageUrl = await notesRepository.photoUrlWithStorage(
          photoFile: event.image!,
          userId: event.userId,
        );
      } else {
        imageUrl = null;
      }

      notesRepository.updateNote(
        text: event.text,
        image: imageUrl,
        id: event.id,
        userId: event.userId,
      );

      emit(const _SuccessUpdateNote());
    } on FirebaseException catch (e) {
      emit(_Error(message: e.toString()));
    } catch (e) {
      emit(_Error(message: e.toString()));
    }
  }

  void _onDeleteNote(_DeleteNote event, Emitter<ControlNoteState> emit) async {
    emit(const _Loading());
    try {
      if (!await hasNetwork()) {
        emit(const _NoInternet());
      }

      await notesRepository.deleteNote(
        id: event.note.id,
        userId: event.userId,
      );

      if (event.note.image != null) {
        await notesRepository.deletePhotoWithStorage(event.note.image!);
      }

      emit(const _SuccessDeleteNote());
    } on FirebaseException catch (e) {
      emit(_Error(message: e.toString()));
    } catch (e) {
      emit(_Error(message: e.toString()));
    }
  }
}
