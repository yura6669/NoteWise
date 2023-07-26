part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class _Load extends SettingsEvent {
  const _Load({
    required this.userId,
  });

  final String userId;

  @override
  List<Object> get props => [userId];
}

class _SignOut extends SettingsEvent {
  const _SignOut();
}
