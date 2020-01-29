import 'package:flutter/widgets.dart';
import 'package:nvmtech/src/styles/color_style.dart';

class AppGradient {
  static const LinearGradient BLUE_GREEN_LINEARGRADIENT = const LinearGradient(
    begin: Alignment(0.86, 0.14),
    end: Alignment(0.12, 1),
    colors: [AppColor.TOPAZ, AppColor.BLUISH],
  );
}
