import 'package:flutter/material.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';

homeAppBar({
  required BuildContext context,
  required String greeting,
  required String name,
}) {
  return AppBar(
    backgroundColor: AppColors.primaryColor,
    automaticallyImplyLeading: false,
    elevation: 0,
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
        '$greeting, $name',
        style: TextStyle(
          fontSize: Utils.adaptiveWidth(context, 7),
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
          color: AppColors.textColor,
        ),
      ),
    ),
    leading: IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.settings_outlined,
        size: Utils.adaptiveWidth(context, 7),
        color: AppColors.textColor,
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.note_add_outlined,
          size: Utils.adaptiveWidth(context, 7),
          color: AppColors.textColor,
        ),
      ),
    ],
  );
}
