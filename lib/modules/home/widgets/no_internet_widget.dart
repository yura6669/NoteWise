import 'package:flutter/material.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback onTap;
  const NoInternetWidget({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.all(Utils.adaptiveWidth(context, 5)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please check your internet connection and try again',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Utils.adaptiveWidth(context, 7),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(height: Utils.adaptiveHeight(context, 3)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: Utils.adaptiveWidth(context, 5),
                    vertical: Utils.adaptiveHeight(context, 2),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      Utils.adaptiveWidth(context, 2),
                    ),
                  ),
                ),
                onPressed: onTap,
                child: Text(
                  'Try again',
                  style: TextStyle(
                    fontSize: Utils.adaptiveWidth(context, 6),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    color: AppColors.textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
