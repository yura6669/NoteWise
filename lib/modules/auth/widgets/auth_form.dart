import 'package:flutter/material.dart';
import 'package:notewise/modules/forgot_password/forgot_password_screen.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'package:notewise/modules/widgets/field.dart';

class AuthForm extends StatelessWidget {
  final GlobalKey<FormState> authKey;
  final TextEditingController email;
  final TextEditingController password;
  const AuthForm({
    required this.authKey,
    required this.email,
    required this.password,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: authKey,
      child: Column(
        children: [
          Field(
            controller: email,
            labelText: 'Email',
            hintText: 'Email',
            validator: (value) => _emailValidator(value),
            prefixIcon: const Icon(
              Icons.email,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          Field(
            controller: password,
            labelText: 'Password',
            hintText: 'Password',
            validator: (value) => _passwordValidator(value),
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.black,
            ),
            suffixIcon: _forgotBtn(context),
            obscureText: true,
          ),
        ],
      ),
    );
  }

  Widget _forgotBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: TextButton(
        style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
        ),
        onPressed: () =>
            Navigator.pushNamed(context, ForgotPasswordScreen.route),
        child: Text(
          'Forgot',
          style: TextStyle(
            fontSize: Utils.adaptiveWidth(context, 5),
            fontWeight: FontWeight.normal,
            fontFamily: 'Roboto',
            color: AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }
}
