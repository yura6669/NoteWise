import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/core/di/locator.dart';
import 'package:notewise/modules/auth/auth_screen.dart';
import 'package:notewise/modules/home/home_screen.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/splash/bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  static const route = 'splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashBloc _splashBloc;

  @override
  void initState() {
    super.initState();
    _splashBloc = locator.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<SplashBloc, SplashState>(
        listener: _listener,
        child: BlocBuilder<SplashBloc, SplashState>(
          bloc: _splashBloc,
          builder: (context, state) {
            if (state.isError) {
              return Center(
                child: Text(
                  'There was an error: ${state.error}',
                  style: const TextStyle(
                    color: AppColors.errorColor,
                    fontSize: 24,
                  ),
                ),
              );
            } else {
              return Center(
                child: Image.asset('assets/logo.png'),
              );
            }
          },
        ),
      ),
    );
  }

  void _listener(BuildContext context, SplashState state) {
    if (state.isLoaded) {
      if (state.user == null) {
        Navigator.pushNamed(context, AuthScreen.route);
      } else {
        Navigator.pushNamed(context, HomeScreen.routeName,
            arguments: state.user);
      }
    }
  }
}
