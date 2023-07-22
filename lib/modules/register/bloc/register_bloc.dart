import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/core/repositories/firebase_repository.dart';
import 'package:notewise/core/repositories/user_repository.dart';
import 'package:notewise/modules/resorses/internet.dart';

part 'register_event.dart';
part 'register_state.dart';

extension RegisterBlocX on RegisterBloc {
  void register({
    required String fullName,
    required String email,
    required String password,
  }) =>
      add(_Register(
        fullname: fullName,
        email: email,
        password: password,
      ));
}

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required this.userRepository,
    required this.firebaseRepository,
  }) : super(const _Initial()) {
    on<_Register>(_register);
  }

  final IUserRepository userRepository;
  final IFirebaseRepository firebaseRepository;

  Future<void> _register(_Register event, Emitter<RegisterState> emit) async {
    emit(const _Loading());
    try {
      if (!await hasNetwork()) {
        emit(const _NoInternet());
        return;
      }
      final credential = await firebaseRepository.register(
        email: event.email,
        password: event.password,
      );
      await userRepository.addUser(
        id: credential.user!.uid,
        fullName: event.fullname,
        email: event.email,
        password: event.password,
      );
      emit(const _Success());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(
          const _Success(isUserExist: true),
        );
      } else {
        emit(_Error(error: e.toString()));
      }
    } catch (e) {
      emit(_Error(error: e.toString()));
    }
  }
}
