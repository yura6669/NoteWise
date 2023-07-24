part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class _Load extends HomeEvent {
  final UserModel model;
  const _Load({
    required this.model,
  });
}
