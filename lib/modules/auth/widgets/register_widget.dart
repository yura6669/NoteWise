import 'package:flutter/material.dart';
import 'package:notewise/modules/register/register_screen.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'package:notewise/modules/widgets/ink_wrapper.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account?',
          style: TextStyle(
            fontSize: Utils.adaptiveWidth(context, 5),
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto',
            color: AppColors.textColor.withOpacity(0.5),
          ),
        ),
        InkWrapper(
          radius: 0,
          onTap: () => Navigator.pushNamed(context, RegisterScreen.routeName),
          child: Text(
            ' Sign Up',
            style: TextStyle(
              fontSize: Utils.adaptiveWidth(context, 5),
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto',
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
