import 'package:flutter/material.dart';
import 'package:nvmtech/src/styles/color_style.dart';

class AppTheme {
  static ThemeData LIGHT_THEME = ThemeData(
    primaryColor: AppColor.PRIMARY_COLOR,
    brightness: Brightness.light,
    platform: TargetPlatform.iOS,
    fontFamily: 'NunitoSans',
  );
}
