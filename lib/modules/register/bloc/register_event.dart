part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class _Register extends RegisterEvent {
  const _Register({
    required this.email,
    required this.password,
    required this.fullname,
  });

  final String email;
  final String password;
  final String fullname;
}
