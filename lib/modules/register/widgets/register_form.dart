import 'package:flutter/material.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/widgets/field.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> registerKey;
  final TextEditingController fullName;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController confirmPassword;
  const RegisterForm(
      {required this.registerKey,
      required this.fullName,
      required this.email,
      required this.password,
      required this.confirmPassword,
      super.key});

  @override
  State<RegisterForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<RegisterForm> {
  late bool _hivePas;
  late bool _hiveConPas;

  @override
  void initState() {
    _hivePas = true;
    _hiveConPas = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.registerKey,
      child: Column(
        children: [
          Field(
            controller: widget.fullName,
            labelText: 'Full Name',
            hintText: 'Full Name',
            validator: (value) => _fullNameValidator(value),
            prefixIcon: const Icon(
              Icons.person_outline,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          Field(
            controller: widget.email,
            labelText: 'Email',
            hintText: 'Email',
            validator: (value) => _emailValidator(value),
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          Field(
            controller: widget.password,
            labelText: 'Password',
            hintText: 'Password',
            validator: (value) => _passwordValidator(value),
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Colors.black,
            ),
            obscureText: _hivePas,
            suffixIcon: _suffixShowPasIcon(),
          ),
          const SizedBox(height: 30),
          Field(
            controller: widget.confirmPassword,
            labelText: 'Confirm Password',
            hintText: 'Confirm Password',
            validator: (value) => _confilmPasswordValidator(value),
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Colors.black,
            ),
            obscureText: _hiveConPas,
            suffixIcon: _suffixShowConfPasIcon(),
          ),
        ],
      ),
    );
  }

  Widget? _suffixShowPasIcon() {
    return IconButton(
      onPressed: () => setState(() {
        _hivePas = !_hivePas;
      }),
      icon: !_hivePas
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
      color: AppColors.textColor,
    );
  }

  Widget? _suffixShowConfPasIcon() {
    return IconButton(
      onPressed: () => setState(() {
        _hiveConPas = !_hiveConPas;
      }),
      icon: !_hiveConPas
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
      color: AppColors.textColor,
    );
  }

  String? _fullNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
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
    } else if (value != widget.confirmPassword.text) {
      return 'Password does not match';
    }
    return null;
  }

  String? _confilmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (value != widget.password.text) {
      return 'Password does not match';
    }
    return null;
  }
}
