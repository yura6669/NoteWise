import 'package:flutter/material.dart';
import 'package:notewise/modules/resorses/app_colors.dart';

class InkWrapper extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final double radius;

  const InkWrapper({
    Key? key,
    required this.child,
    required this.onTap,
    this.radius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned.fill(
          child: Material(
            color: AppColors.transparent,
            child: Ink(
              child: InkWell(
                  hoverColor: AppColors.hoverColor,
                  splashColor: AppColors.hoverColor,
                  onTap: onTap,
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(radius))),
            ),
          ),
        ),
      ],
    );
  }
}
