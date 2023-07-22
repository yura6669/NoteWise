import 'package:flutter/material.dart';

class Utils {
  static double adaptiveWidth(BuildContext context, double percent) {
    return MediaQuery.of(context).size.width * (percent / 100);
  }

  static double adaptiveHeight(BuildContext context, double percent) {
    return MediaQuery.of(context).size.height * (percent / 100);
  }
}
