import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/core/di/locator.dart';
import 'package:notewise/modules/register/bloc/register_bloc.dart';
import 'package:notewise/modules/register/widgets/auth_widget.dart';
import 'package:notewise/modules/register/widgets/register_btn.dart';
import 'package:notewise/modules/register/widgets/register_form.dart';
import 'package:notewise/modules/register/widgets/register_title.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'dart:math' as math;

import 'package:notewise/modules/widgets/custom_snack_bar.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = 'register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late GlobalKey<FormState> _registerKey;
  late TextEditingController _fullName;
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _confirmPassword;
  late RegisterBloc _registerBloc;

  @override
  void initState() {
    _registerKey = GlobalKey<FormState>();
    _fullName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    _registerBloc = locator.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _registerBloc,
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: _listener,
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return Stack(
              children: [
                _buildContent(),
                if (state.isLoading) ...[
                  Container(
                    color: AppColors.textColor.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                ],
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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: Utils.adaptiveHeight(context, 1),
            left: Utils.adaptiveWidth(context, 10),
            right: Utils.adaptiveWidth(context, 10),
            bottom: Utils.adaptiveHeight(context, 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const RegisterTitle(),
                  const SizedBox(width: 20),
                  Image.asset(
                    'assets/logo.png',
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              RegisterForm(
                registerKey: _registerKey,
                fullName: _fullName,
                email: _email,
                password: _password,
                confirmPassword: _confirmPassword,
              ),
              const SizedBox(height: 40),
              RegisterBtn(
                registerKey: _registerKey,
                fullName: _fullName,
                email: _email,
                password: _password,
                confirmPassword: _confirmPassword,
              ),
              const Spacer(),
              const AuthWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, RegisterState state) {
    if (state.isSuccess) {
      if (state.isUserExist) {
        showSnackbar(
          context,
          text:
              'User with this email already exists. Please, try to login or reset password.',
          color: AppColors.errorColor,
        );
      } else {
        showSnackbar(
          context,
          text:
              'You have successfully registered. Please, sign in to your account.',
          color: AppColors.success,
        );
        Navigator.pop(context);
      }
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
        text: 'Something went wrong. Please, try again.',
        color: AppColors.errorColor,
      );
    }
  }
}
