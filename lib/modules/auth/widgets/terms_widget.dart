// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/internet.dart';
import 'package:notewise/modules/resorses/urls.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'package:notewise/modules/widgets/ink_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsWidget extends StatelessWidget {
  const TermsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'By logging in you agree to our',
          style: TextStyle(
            fontSize: Utils.adaptiveWidth(context, 5),
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto',
            color: AppColors.textColor.withOpacity(0.5),
          ),
        ),
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWrapper(
                radius: 0,
                onTap: () => _onOpenTerms(context, Urls.privacyPolicyUrl),
                child: Text(
                  ' Privacy Policy ',
                  style: TextStyle(
                    fontSize: Utils.adaptiveWidth(context, 5),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Roboto',
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Text(
                'and',
                style: TextStyle(
                  fontSize: Utils.adaptiveWidth(context, 5),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                  color: AppColors.textColor.withOpacity(0.5),
                ),
              ),
              InkWrapper(
                radius: 0,
                onTap: () => _onOpenTerms(context, Urls.termsAndConditionsUrl),
                child: Text(
                  ' Terms and Conditions. ',
                  style: TextStyle(
                    fontSize: Utils.adaptiveWidth(context, 5),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Roboto',
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _onOpenTerms(BuildContext context, String url) async {
    if (await hasNetwork()) {
      await launchUrl(Uri.parse(url));
    } else {
      noInternetConnection(context);
    }
  }
}
