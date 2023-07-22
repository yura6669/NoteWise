import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/modules/auth/bloc/auth_bloc.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'package:notewise/modules/widgets/ink_wrapper.dart';

class AuthBtn extends StatelessWidget {
  final GlobalKey<FormState> authKey;
  final TextEditingController email;
  final TextEditingController password;
  const AuthBtn(
      {required this.authKey,
      required this.email,
      required this.password,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWrapper(
        radius: 50,
        onTap: () {
          if (authKey.currentState!.validate()) {
            context.read<AuthBloc>().auth(
                  email: email.text.trim(),
                  password: password.text.trim(),
                );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [
                  0.1,
                  0.9,
                ],
                colors: [
                  AppColors.secondaryColor,
                  AppColors.primaryColor,
                ],
              )),
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: Utils.adaptiveWidth(context, 7),
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
