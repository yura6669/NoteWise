import 'package:flutter/material.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'dart:math' as math;

settingsAppBar({
  required BuildContext context,
  required String title,
}) {
  return AppBar(
    backgroundColor: AppColors.primaryColor,
    elevation: 0,
    centerTitle: true,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            AppColors.secondaryColor,
            AppColors.primaryColor,
          ],
        ),
      ),
    ),
    title: FittedBox(
      child: Text(
        title,
        style: TextStyle(
          fontSize: Utils.adaptiveWidth(context, 7),
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
          color: AppColors.textColor,
        ),
      ),
    ),
    leading: Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: IconButton(
        icon: Icon(
          Icons.arrow_right_alt_outlined,
          color: AppColors.textColor,
          size: Utils.adaptiveWidth(context, 8),
        ),
        onPressed: () => Navigator.pop(context),
      ),
    ),
  );
}
