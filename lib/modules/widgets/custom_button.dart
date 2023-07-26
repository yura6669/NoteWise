import 'package:flutter/material.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'package:notewise/modules/widgets/ink_wrapper.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double size;
  const CustomButton({
    required this.text,
    required this.onTap,
    this.size = 7,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWrapper(
      radius: 50,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                0.1,
                0.9,
              ],
              colors: [
                AppColors.secondaryColor,
                AppColors.primaryColor,
              ],
            )),
        child: Text(
          text,
          style: TextStyle(
            fontSize: Utils.adaptiveWidth(context, size),
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
