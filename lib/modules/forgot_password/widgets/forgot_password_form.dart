import 'package:flutter/material.dart';
import 'package:notewise/modules/widgets/field.dart';

class ForgotPasswordForm extends StatelessWidget {
  final GlobalKey<FormState> authKey;
  final TextEditingController email;
  const ForgotPasswordForm({
    required this.authKey,
    required this.email,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: authKey,
      child: Field(
        controller: email,
        labelText: 'Email',
        hintText: 'Email',
        validator: (value) => _emailValidator(value),
        prefixIcon: const Icon(
          Icons.email,
          color: Colors.black,
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
}
