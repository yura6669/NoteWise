part of 'splash_bloc.dart';

extension SplashStateX on SplashState {
  bool get isInitial => this is _Initial;

  bool get isLoaded => this is _Loaded;

  UserModel? get user => (this as _Loaded).user;

  bool get isError => this is _Error;

  String get error => (this as _Error).error;
}

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class _Initial extends SplashState {
  const _Initial();
}

class _Loaded extends SplashState {
  const _Loaded({required this.user});

  final UserModel? user;
}

class _Error extends SplashState {
  const _Error({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
