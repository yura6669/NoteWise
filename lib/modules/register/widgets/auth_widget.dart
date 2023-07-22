import 'package:flutter/material.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'package:notewise/modules/widgets/ink_wrapper.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: TextStyle(
            fontSize: Utils.adaptiveWidth(context, 5),
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto',
            color: AppColors.textColor.withOpacity(0.5),
          ),
        ),
        InkWrapper(
          radius: 0,
          onTap: () => Navigator.pop(context),
          child: Text(
            ' Sign in',
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
