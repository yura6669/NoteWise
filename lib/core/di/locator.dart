import 'package:get_it/get_it.dart';
import 'package:notewise/core/repositories/firebase_repository.dart';
import 'package:notewise/core/repositories/notes_repository.dart';
import 'package:notewise/core/repositories/user_repository.dart';
import 'package:notewise/modules/auth/bloc/auth_bloc.dart';
import 'package:notewise/modules/control_note/bloc/control_note_bloc.dart';
import 'package:notewise/modules/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:notewise/modules/home/bloc/home_bloc.dart';
import 'package:notewise/modules/register/bloc/register_bloc.dart';
import 'package:notewise/modules/settings/bloc/settings_bloc.dart';
import 'package:notewise/modules/splash/bloc/splash_bloc.dart';

GetIt locator = GetIt.instance;

void setupServiceLocator() {
  locator.registerSingleton<IUserRepository>(UserRepository());

  locator.registerSingleton<IFirebaseRepository>(FirebaseRepository());

  locator.registerSingleton<INotesRepository>(NotesRepository());

  locator.registerFactory(() {
    return SplashBloc(
      userRepository: locator.get(),
    );
  });

  locator.registerFactory(() {
    return RegisterBloc(
      userRepository: locator.get(),
      firebaseRepository: locator.get(),
    );
  });

  locator.registerFactory(() {
    return AuthBloc(
      userRepository: locator.get(),
      firebaseRepository: locator.get(),
    );
  });

  locator.registerFactory(() {
    return ForgotPasswordBloc(
      firebaseRepository: locator.get(),
      userRepository: locator.get(),
    );
  });

  locator.registerFactory(() {
    return HomeBloc(
      notesRepository: locator.get(),
    );
  });

  locator.registerFactory(() {
    return ControlNoteBloc(
      notesRepository: locator.get(),
    );
  });

  locator.registerFactory(() {
    return SettingsBloc(
      userRepository: locator.get(),
      firebaseRepository: locator.get(),
    );
  });
}
