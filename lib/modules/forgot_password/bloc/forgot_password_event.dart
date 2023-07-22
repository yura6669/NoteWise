part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class _Restore extends ForgotPasswordEvent {
  const _Restore({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}
