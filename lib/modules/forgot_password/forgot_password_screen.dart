import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/core/di/locator.dart';
import 'package:notewise/modules/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:notewise/modules/forgot_password/widgets/forgot_password_btn.dart';
import 'package:notewise/modules/forgot_password/widgets/forgot_password_form.dart';
import 'package:notewise/modules/forgot_password/widgets/forgot_password_title.dart';
import 'package:notewise/modules/forgot_password/widgets/forgot_password_subtitle.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'dart:math' as math;

import 'package:notewise/modules/widgets/custom_snack_bar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const route = 'forgot';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<ForgotPasswordScreen> {
  late GlobalKey<FormState> authKey;
  late TextEditingController email;
  late ForgotPasswordBloc _forgotPasswordBloc;

  @override
  void initState() {
    authKey = GlobalKey<FormState>();
    email = TextEditingController();
    _forgotPasswordBloc = locator.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _forgotPasswordBloc,
      child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: _listener,
        child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
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
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: IconButton(
            icon: Icon(
              Icons.arrow_right_alt_outlined,
              color: AppColors.textColor,
              size: Utils.adaptiveWidth(context, 8),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ForgotPasswordTitle(),
                  Image.asset(
                    'assets/logo.png',
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const ForgotPasswordSubtitle(),
              const SizedBox(height: 50),
              ForgotPasswordForm(
                authKey: authKey,
                email: email,
              ),
              const SizedBox(height: 40),
              ForgotPasswordBtn(
                authKey: authKey,
                email: email,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, ForgotPasswordState state) {
    if (state.isNoInternet) {
      showSnackbar(
        context,
        text:
            'No internet connection. Please, check your internet connection and try again.',
        color: AppColors.errorColor,
      );
    } else if (state.isNoUser) {
      showSnackbar(
        context,
        text:
            'No user found with this email. Please, check your email and try again.',
        color: AppColors.errorColor,
      );
    } else if (state.isSuccess) {
      showSnackbar(
        context,
        text: 'Password reset email sent. Please, check your email.',
        color: AppColors.success,
      );
      Navigator.pop(context);
    } else if (state.isError) {
      showSnackbar(
        context,
        text: 'Something went wrong: ${state.error}. Please, try again.',
        color: AppColors.errorColor,
      );
    }
  }
}
