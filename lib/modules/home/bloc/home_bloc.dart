import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/core/models/note.dart';
import 'package:notewise/core/models/user.dart';
import 'package:notewise/core/repositories/notes_repository.dart';
import 'package:notewise/modules/resorses/internet.dart';

part 'home_event.dart';
part 'home_state.dart';

extension HomeBlocX on HomeBloc {
  void load(UserModel model) => add(_Load(model: model));
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.notesRepository,
  }) : super(const _Initial()) {
    on<_Load>(_onLoad);
  }

  final INotesRepository notesRepository;

  Future<void> _onLoad(_Load event, Emitter<HomeState> emit) async {
    emit(const _Loading());
    try {
      if (!await hasNetwork()) {
        emit(const _NoInternet());
        return;
      }
      final user = event.model;
      final notes = await notesRepository.getNotes(user.id);
      emit(_Loaded(
        user: user,
        notes: notes,
        greeting: _gretting(),
      ));
    } on FirebaseAuthException catch (e) {
      emit(_Error(message: e.toString()));
    } catch (e) {
      emit(_Error(message: e.toString()));
    }
  }

  String _gretting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }
}
