import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/modules/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:notewise/modules/widgets/custom_button.dart';

class ForgotPasswordBtn extends StatelessWidget {
  final GlobalKey<FormState> authKey;
  final TextEditingController email;
  const ForgotPasswordBtn(
      {required this.authKey, required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: CustomButton(
        text: 'Restore',
        onTap: () {
          if (authKey.currentState!.validate()) {
            context
                .read<ForgotPasswordBloc>()
                .restore(email: email.text.trim());
          }
        },
      ),
    );
  }
}
