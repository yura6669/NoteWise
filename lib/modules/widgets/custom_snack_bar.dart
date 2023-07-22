import 'package:flutter/material.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';

void showSnackbar(
  BuildContext context, {
  required String text,
  required Color color,
}) {
  final snackBar = SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.background,
        fontFamily: 'Roboto',
        fontSize: Utils.adaptiveWidth(context, 5),
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}
