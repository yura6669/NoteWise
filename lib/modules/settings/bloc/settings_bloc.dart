import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/core/models/user.dart';
import 'package:notewise/core/repositories/firebase_repository.dart';
import 'package:notewise/core/repositories/user_repository.dart';
import 'package:notewise/modules/resorses/internet.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'settings_event.dart';
part 'settings_state.dart';

extension SettingsBlocX on SettingsBloc {
  void load({
    required String userId,
  }) {
    add(_Load(userId: userId));
  }

  void signOut() {
    add(const _SignOut());
  }
}

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.userRepository,
    required this.firebaseRepository,
  }) : super(const _Initial()) {
    on<_Load>(_onLoad);
    on<_SignOut>(_onSignOut);
  }

  final IUserRepository userRepository;
  final IFirebaseRepository firebaseRepository;

  void _onLoad(_Load event, Emitter<SettingsState> emit) async {
    emit(const _Loading());
    try {
      if (!await hasNetwork()) {
        emit(const _NoInternet());
        return;
      }
      final user = await userRepository.getUserById(userId: event.userId);
      if (user != null) {
        final PackageInfo packageInfo = await PackageInfo.fromPlatform();
        emit(_Loaded(
          user: user,
          appVersion: packageInfo.version,
        ));
      }
    } on FirebaseException catch (e) {
      emit(_Error(message: e.message ?? ''));
    } catch (e) {
      emit(_Error(message: e.toString()));
    }
  }

  void _onSignOut(_SignOut event, Emitter<SettingsState> emit) async {
    emit(const _Loading());
    try {
      if (!await hasNetwork()) {
        emit(const _NoInternet());
        return;
      }
      await userRepository.deleteInstitutionWithCash();
      emit(const _SignedOut());
    } on FirebaseException catch (e) {
      emit(_Error(message: e.message ?? ''));
    } catch (e) {
      emit(_Error(message: e.toString()));
    }
  }
}
