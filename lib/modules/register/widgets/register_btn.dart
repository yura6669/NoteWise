import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/modules/register/bloc/register_bloc.dart';
import 'package:notewise/modules/widgets/custom_button.dart';

class RegisterBtn extends StatelessWidget {
  final GlobalKey<FormState> registerKey;
  final TextEditingController fullName;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController confirmPassword;
  const RegisterBtn({
    required this.registerKey,
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: CustomButton(
        text: 'Register',
        onTap: () {
          if (registerKey.currentState!.validate()) {
            context.read<RegisterBloc>().register(
                  fullName: fullName.text.trim(),
                  email: email.text.trim(),
                  password: password.text.trim(),
                );
          }
        },
      ),
    );
  }
}
