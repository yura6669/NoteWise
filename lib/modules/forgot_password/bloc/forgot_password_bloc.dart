import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/core/models/user.dart';
import 'package:notewise/core/repositories/firebase_repository.dart';
import 'package:notewise/core/repositories/user_repository.dart';
import 'package:notewise/modules/resorses/internet.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

extension ForgotPasswordBlocX on ForgotPasswordBloc {
  void restore({required String email}) => add(_Restore(email: email));
}

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({
    required this.firebaseRepository,
    required this.userRepository,
  }) : super(const _Initial()) {
    on<_Restore>(_restore);
  }

  final IFirebaseRepository firebaseRepository;
  final IUserRepository userRepository;

  void _restore(_Restore event, Emitter<ForgotPasswordState> emit) async {
    emit(const _Loading());
    try {
      if (!await hasNetwork()) {
        emit(const _NoInternet());
        return;
      }
      final UserModel? user = await userRepository.getUser(event.email);
      if (user != null) {
        firebaseRepository.restorePassword(email: event.email);
        emit(const _Success());
      } else {
        emit(const _NoUser());
      }
    } on FirebaseAuthException catch (e) {
      emit(_Error(error: e.message.toString()));
    } catch (e) {
      emit(_Error(error: e.toString()));
    }
  }
}
