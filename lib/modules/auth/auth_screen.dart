import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/core/di/locator.dart';
import 'package:notewise/modules/auth/bloc/auth_bloc.dart';
import 'package:notewise/modules/auth/widgets/auth_btn.dart';
import 'package:notewise/modules/auth/widgets/auth_form.dart';
import 'package:notewise/modules/auth/widgets/auth_subtitle.dart';
import 'package:notewise/modules/auth/widgets/auth_title.dart';
import 'package:notewise/modules/auth/widgets/register_widget.dart';
import 'package:notewise/modules/auth/widgets/terms_widget.dart';
import 'package:notewise/modules/home/home_screen.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'package:notewise/modules/widgets/custom_snack_bar.dart';

class AuthScreen extends StatefulWidget {
  static const route = 'auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late GlobalKey<FormState> authKey;
  late TextEditingController email;
  late TextEditingController password;
  late AuthBloc _authBloc;

  @override
  void initState() {
    authKey = GlobalKey<FormState>();
    email = TextEditingController();
    password = TextEditingController();
    _authBloc = locator.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authBloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: _listener,
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Stack(
              children: [
                _buildContent(),
                if (state.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: Utils.adaptiveHeight(context, 15),
            left: Utils.adaptiveWidth(context, 10),
            right: Utils.adaptiveWidth(context, 10),
            bottom: Utils.adaptiveHeight(context, 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const AuthTitle(),
                  const SizedBox(width: 20),
                  Image.asset(
                    'assets/logo.png',
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const AuthSubtitle(),
              const SizedBox(height: 50),
              AuthForm(
                authKey: authKey,
                email: email,
                password: password,
              ),
              const SizedBox(height: 40),
              AuthBtn(
                authKey: authKey,
                email: email,
                password: password,
              ),
              const Spacer(),
              const RegisterWidget(),
              const SizedBox(height: 20),
              const TermsWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, AuthState state) {
    if (state.isNoUser) {
      showSnackbar(
        context,
        text:
            'User is not found. Please, check your email and password and try again.',
        color: AppColors.errorColor,
      );
    } else if (state.isWrongPassword) {
      showSnackbar(
        context,
        text:
            'Wrong password. Please, check your email and password and try again.',
        color: AppColors.errorColor,
      );
    } else if (state.isSuccess) {
      Navigator.pushNamed(
        context,
        HomeScreen.routeName,
        arguments: state.user,
      );
    } else if (state.isNoInternet) {
      showSnackbar(
        context,
        text:
            'No internet connection. Please, check your internet connection and try again.',
        color: AppColors.errorColor,
      );
    } else if (state.isError) {
      showSnackbar(
        context,
        text: 'Something went wrong: ${state.error}. Please, try again.',
        color: AppColors.errorColor,
      );
    }
  }
}
