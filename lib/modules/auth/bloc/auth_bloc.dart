import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/core/models/user.dart';
import 'package:notewise/core/repositories/firebase_repository.dart';
import 'package:notewise/core/repositories/user_repository.dart';
import 'package:notewise/modules/resorses/internet.dart';

part 'auth_event.dart';
part 'auth_state.dart';

extension AuthBlocX on AuthBloc {
  void auth({
    required String email,
    required String password,
  }) =>
      add(_Auth(
        email: email,
        password: password,
      ));
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.firebaseRepository,
    required this.userRepository,
  }) : super(const _Initial()) {
    on<_Auth>(_auth);
  }
  final IFirebaseRepository firebaseRepository;
  final IUserRepository userRepository;

  Future<void> _auth(_Auth event, Emitter<AuthState> emit) async {
    emit(const _Loading());
    try {
      if (!await hasNetwork()) {
        emit(const _NoInternet());
        return;
      }
      final credential = await firebaseRepository.signIn(
        email: event.email,
        password: event.password,
      );
      if (credential.user != null) {
        final UserModel? user = await userRepository.getUser(event.email);
        if (user != null) {
          await userRepository.saveUserToCache(user);
          emit(_Success(user: user));
        } else {
          emit(const _NoUser());
        }
      } else {
        emit(const _NoUser());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(const _NoUser());
      } else if (e.code == 'wrong-password') {
        emit(const _WrongPassword());
      } else {
        emit(_Error(error: e.toString()));
      }
    } catch (e) {
      emit(_Error(error: e.toString()));
    }
  }
}
