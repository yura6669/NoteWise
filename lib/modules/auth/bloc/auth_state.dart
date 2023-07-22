part of 'auth_bloc.dart';

extension AuthStateX on AuthState {
  bool get isInitial => this is _Initial;

  bool get isLoading => this is _Loading;

  bool get isSuccess => this is _Success;

  UserModel get user => (this as _Success).user;

  bool get isNoUser => this is _NoUser;

  bool get isWrongPassword => this is _WrongPassword;

  bool get isNoInternet => this is _NoInternet;

  bool get isError => this is _Error;

  String get error => (this as _Error).error;
}

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class _Initial extends AuthState {
  const _Initial();
}

class _Loading extends AuthState {
  const _Loading();
}

class _Success extends AuthState {
  const _Success({required this.user});

  final UserModel user;
}

class _NoUser extends AuthState {
  const _NoUser();
}

class _WrongPassword extends AuthState {
  const _WrongPassword();
}

class _NoInternet extends AuthState {
  const _NoInternet();
}

class _Error extends AuthState {
  const _Error({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
