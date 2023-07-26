import 'package:flutter/material.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';

class Field extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String? Function(String?) validator;
  final Icon prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLines;
  const Field(
      {required this.controller,
      required this.hintText,
      required this.labelText,
      required this.validator,
      required this.prefixIcon,
      this.obscureText = false,
      this.maxLines,
      this.suffixIcon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 15, color: Colors.black.withOpacity(0.2)),
        ],
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        obscuringCharacter: '*',
        maxLines: maxLines,
        style: TextStyle(
          fontSize: Utils.adaptiveWidth(context, 5),
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
          color: Colors.black,
        ),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          fillColor: AppColors.background,
          filled: true,
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: Utils.adaptiveWidth(context, 5),
            fontWeight: FontWeight.normal,
            fontFamily: 'Roboto',
            color: Colors.black.withOpacity(0.5),
          ),
          hintStyle: TextStyle(
            fontSize: Utils.adaptiveWidth(context, 5),
            fontWeight: FontWeight.normal,
            fontFamily: 'Roboto',
            color: Colors.black,
          ),
          errorStyle: TextStyle(
            fontSize: Utils.adaptiveWidth(context, 4),
            fontWeight: FontWeight.normal,
            fontFamily: 'Roboto',
            color: AppColors.errorColor,
          ),
          prefix: prefixIcon,
          suffixIcon: suffixIcon,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
        validator: validator,
      ),
    );
  }
}
