// ignore_for_file: library_private_types_in_public_api

part of 'home_bloc.dart';

extension HomeStateX on HomeState {
  bool get isInitial => this is _Initial;

  bool get isLoading => this is _Loading;

  bool get isLoaded => this is _Loaded;

  bool get isNoInternet => this is _NoInternet;

  bool get isError => this is _Error;

  _Initial get asInitial => this as _Initial;

  _Loading get asLoading => this as _Loading;

  _Loaded get asLoaded => this as _Loaded;

  UserModel get user => asLoaded.user;

  List<NoteModel> get notes => asLoaded.notes;

  String get greeting => asLoaded.greeting;

  _NoInternet get asNoInternet => this as _NoInternet;

  _Error get asError => this as _Error;

  String get errorMessage => asError.message;
}

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class _Initial extends HomeState {
  const _Initial();
}

class _Loading extends HomeState {
  const _Loading();
}

class _Loaded extends HomeState {
  final UserModel user;
  final List<NoteModel> notes;
  final String greeting;

  const _Loaded({
    required this.user,
    required this.notes,
    required this.greeting,
  });

  @override
  List<Object> get props => [user, notes, greeting];
}

class _NoInternet extends HomeState {
  const _NoInternet();
}

class _Error extends HomeState {
  final String message;

  const _Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
