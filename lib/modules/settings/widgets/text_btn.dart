import 'package:flutter/material.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'package:notewise/modules/widgets/ink_wrapper.dart';

class TextBtn extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  const TextBtn({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWrapper(
      onTap: onTap,
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: Utils.adaptiveHeight(context, 2)),
        child: Row(
          children: [
            Image.asset(icon, height: 30, width: 30, color: Colors.black),
            SizedBox(width: Utils.adaptiveWidth(context, 5)),
            Text(
              title,
              style: TextStyle(
                fontSize: Utils.adaptiveWidth(context, 5),
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
