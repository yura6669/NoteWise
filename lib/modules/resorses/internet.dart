import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/widgets/custom_snack_bar.dart';

Future<bool> hasNetwork() async {
  if (kIsWeb) {
    return true;
  }
  try {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

dynamic noInternetConnection(BuildContext context) => showSnackbar(
      context,
      text:
          'No internet connection. Please check your connection and try again.',
      color: AppColors.errorColor,
    );
