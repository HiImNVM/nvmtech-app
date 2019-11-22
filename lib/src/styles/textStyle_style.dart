import 'package:flutter/material.dart';
import 'package:nvmtech/src/styles/color_style.dart';

class AppTextStyle {
  static const TextStyle WHITE_W700_NORMAL_F16 = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontFamily: 'NunitoSans',
      fontStyle: FontStyle.normal,
      fontSize: 16.0);

  static const TextStyle BLACK_W700_NORMAL_F18 = const TextStyle(
      color: const Color(0xff404040),
      fontWeight: FontWeight.w700,
      fontFamily: 'NunitoSans',
      fontStyle: FontStyle.normal,
      fontSize: 18.0);

  static const TextStyle BLACK_W600_NORMAL_F12 = const TextStyle(
      color: const Color(0xff404040),
      fontWeight: FontWeight.w600,
      fontFamily: 'NunitoSans',
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const TextStyle TOPAZ_W600_NORMAL_F12 = const TextStyle(
      color: AppColor.TOPAZ,
      fontWeight: FontWeight.w600,
      fontFamily: 'NunitoSans',
      fontStyle: FontStyle.normal,
      fontSize: 12.0);
}
