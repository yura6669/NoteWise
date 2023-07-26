part of 'settings_bloc.dart';

extension SettingsStateX on SettingsState {
  bool get isInitial => this is _Initial;
  bool get isLoading => this is _Loading;
  bool get isLoaded => this is _Loaded;
  bool get isSignedOut => this is _SignedOut;

  UserModel get user => (this as _Loaded).user;

  String get appVersion => (this as _Loaded).appVersion;

  bool get isNoInternet => this is _NoInternet;
  bool get isError => this is _Error;
}

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class _Initial extends SettingsState {
  const _Initial();
}

class _Loading extends SettingsState {
  const _Loading();
}

class _Loaded extends SettingsState {
  final UserModel user;
  final String appVersion;

  const _Loaded({
    required this.user,
    required this.appVersion,
  });

  @override
  List<Object> get props => [user, appVersion];
}

class _SignedOut extends SettingsState {
  const _SignedOut();
}

class _NoInternet extends SettingsState {
  const _NoInternet();
}

class _Error extends SettingsState {
  final String message;

  const _Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
