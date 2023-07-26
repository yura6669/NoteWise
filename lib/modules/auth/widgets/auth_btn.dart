import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/modules/auth/bloc/auth_bloc.dart';
import 'package:notewise/modules/widgets/custom_button.dart';

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
      child: CustomButton(
          text: 'Login',
          onTap: () {
            if (authKey.currentState!.validate()) {
              context.read<AuthBloc>().auth(
                    email: email.text.trim(),
                    password: password.text.trim(),
                  );
            }
          }),
    );
  }
}
