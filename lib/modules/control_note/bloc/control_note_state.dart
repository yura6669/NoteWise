part of 'control_note_bloc.dart';

extension ControlNoteStateX on ControlNoteState {
  bool get isInitial => this is _Initial;
  bool get isLoading => this is _Loading;
  bool get isSuccessAddNote => this is _SuccessAddNote;
  bool get isSuccessUpdateNote => this is _SuccessUpdateNote;
  bool get isSuccessDeleteNote => this is _SuccessDeleteNote;
  bool get isNoInternet => this is _NoInternet;
  bool get isError => this is _Error;
}

abstract class ControlNoteState extends Equatable {
  const ControlNoteState();

  @override
  List<Object> get props => [];
}

class _Initial extends ControlNoteState {
  const _Initial();
}

class _Loading extends ControlNoteState {
  const _Loading();
}

class _SuccessAddNote extends ControlNoteState {
  const _SuccessAddNote();
}

class _SuccessUpdateNote extends ControlNoteState {
  const _SuccessUpdateNote();
}

class _SuccessDeleteNote extends ControlNoteState {
  const _SuccessDeleteNote();
}

class _NoInternet extends ControlNoteState {
  const _NoInternet();
}

class _Error extends ControlNoteState {
  final String message;

  const _Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
