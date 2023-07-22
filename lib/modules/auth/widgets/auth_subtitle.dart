import 'package:flutter/material.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';

class AuthSubtitle extends StatelessWidget {
  const AuthSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Please sign in to continue',
      style: TextStyle(
        fontSize: Utils.adaptiveWidth(context, 5),
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
        color: AppColors.textColor.withOpacity(0.5),
      ),
    );
  }
}
