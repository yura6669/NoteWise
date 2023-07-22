part of 'register_bloc.dart';

extension RegisterStateX on RegisterState {
  bool get isLoading => this is _Loading;

  bool get isSuccess => this is _Success;

  bool get isUserExist => (this as _Success).isUserExist;

  bool get isError => this is _Error;

  bool get isNoInternet => this is _NoInternet;

  String get error => (this as _Error).error;
}

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class _Initial extends RegisterState {
  const _Initial();
}

class _Loading extends RegisterState {
  const _Loading();
}

class _Success extends RegisterState {
  const _Success({
    this.isUserExist = false,
  });

  final bool isUserExist;
}

class _NoInternet extends RegisterState {
  const _NoInternet();
}

class _Error extends RegisterState {
  const _Error({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
