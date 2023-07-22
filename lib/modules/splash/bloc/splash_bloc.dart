import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/core/models/user.dart';
import 'package:notewise/core/repositories/user_repository.dart';

part 'splash_event.dart';
part 'splash_state.dart';

extension SplashBlocX on SplashBloc {
  void load() => add(const _Load());
}

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required this.userRepository}) : super(const _Initial()) {
    on<_Load>(_onLoad);
    load();
  }

  final IUserRepository userRepository;

  void _onLoad(_Load event, Emitter<SplashState> emit) async {
    try {
      final user = await userRepository.getUserWithCache();
      await Future.delayed(const Duration(seconds: 2));
      emit(_Loaded(user: user));
    } catch (e) {
      emit(_Error(error: e.toString()));
    }
  }
}
