import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/core/di/locator.dart';
import 'package:notewise/core/models/user.dart';
import 'package:notewise/firebase_options.dart';
import 'package:notewise/modules/auth/auth_screen.dart';
import 'package:notewise/modules/control_note/control_note_screen.dart';
import 'package:notewise/modules/forgot_password/forgot_password_screen.dart';
import 'package:notewise/modules/home/home_screen.dart';
import 'package:notewise/modules/register/register_screen.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/splash/bloc/splash_bloc.dart';
import 'package:notewise/modules/splash/splash_screen.dart';

class NoteWiseApp extends StatelessWidget {
  const NoteWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _firebaseError(context);
        } else {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SplashBloc(
                  userRepository: locator.get(),
                ),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: const SplashScreen(),
              onGenerateRoute: (settings) {
                return PageRouteBuilder(
                  settings: settings,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    var tween = Tween(
                      begin: begin,
                      end: end,
                    ).chain(
                      CurveTween(
                        curve: curve,
                      ),
                    );

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                  pageBuilder: ((context, animation, secondaryAnimation) {
                    switch (settings.name) {
                      case SplashScreen.route:
                        return const SplashScreen();
                      case AuthScreen.route:
                        return const AuthScreen();
                      case RegisterScreen.routeName:
                        return const RegisterScreen();
                      case HomeScreen.routeName:
                        return HomeScreen(
                          user: settings.arguments as UserModel,
                        );
                      case ForgotPasswordScreen.route:
                        return const ForgotPasswordScreen();
                      case ControlNoteScreen.routeName:
                        return ControlNoteScreen(
                          args: settings.arguments as ControlNoteArgs,
                        );
                      default:
                        return const SplashScreen();
                    }
                  }),
                );
              },
              initialRoute: SplashScreen.route,
            ),
          );
        }
      },
    );
  }

  Widget _firebaseError(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Database initialization error',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  Future<FirebaseApp> _initializeApp() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAnalytics.instance;
    return firebaseApp;
  }
}
