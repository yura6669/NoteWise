part of 'forgot_password_bloc.dart';

extension ForgotPasswordStateX on ForgotPasswordState {
  bool get isInitial => this is _Initial;

  bool get isLoading => this is _Loading;

  bool get isSuccess => this is _Success;

  bool get isNoInternet => this is _NoInternet;

  bool get isNoUser => this is _NoUser;

  bool get isError => this is _Error;

  String get error => (this as _Error).error;
}

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
  
  @override
  List<Object> get props => [];
}

class _Initial extends ForgotPasswordState {
  const _Initial();
}

class _Loading extends ForgotPasswordState {
  const _Loading();
}

class _Success extends ForgotPasswordState {
  const _Success();
}

class _NoInternet extends ForgotPasswordState {
  const _NoInternet();
}

class _NoUser extends ForgotPasswordState {
  const _NoUser();
}

class _Error extends ForgotPasswordState {
  const _Error({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
