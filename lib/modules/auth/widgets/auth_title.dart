import 'package:flutter/material.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Login',
      style: TextStyle(
        fontSize: Utils.adaptiveWidth(context, 12),
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: AppColors.textColor,
      ),
    );
  }
}
