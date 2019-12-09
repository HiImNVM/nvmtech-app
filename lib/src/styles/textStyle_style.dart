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

  static const TextStyle BLACK_W700_NORMAL_F30 = const TextStyle(
      color: const Color(0xff404040),
      fontWeight: FontWeight.w700,
      fontFamily: 'NunitoSans',
      fontStyle: FontStyle.normal,
      fontSize: 30.0);

  static const TextStyle BLACK_W600_NORMAL_F12 = const TextStyle(
      color: const Color(0xff404040),
      fontWeight: FontWeight.w600,
      fontFamily: 'NunitoSans',
      fontStyle: FontStyle.normal,
      fontSize: 12.0);
  
  static const TextStyle BROWNISHGREY_W600_NORMAL_F14 = const TextStyle(
    color: Color(0xff626262),
    fontWeight: FontWeight.w600,
    fontFamily: "NunitoSans",
    fontStyle: FontStyle.normal,
    fontSize: 14.0,
    height: 1.5
  );
  
  static const TextStyle LIGHTGREY_W600_NORMAL_F14 = const TextStyle(
    color: Color(0xff9b9b9b),
    fontWeight: FontWeight.w600,
    fontFamily: "NunitoSans",
    fontStyle: FontStyle.normal,
    fontSize: 14.0,
  );

  static const TextStyle TOPAZ_W600_NORMAL_F12 = const TextStyle(
      color: AppColor.TOPAZ,
      fontWeight: FontWeight.w600,
      fontFamily: 'NunitoSans',
      fontStyle: FontStyle.normal,
      fontSize: 12.0);

  static const TextStyle TOPAZ_W400_NORMAL_F70 = const TextStyle(
      color: const Color(0xff2a99cc),
      fontWeight: FontWeight.w400,
      fontFamily: 'NunitoSans',
      fontStyle: FontStyle.normal,
      fontSize: 70.0);

  static const TextStyle TOPAZ_W400_NORMAL_F16 = const TextStyle(
      color: const Color(0xff2a99cc),
      fontWeight: FontWeight.w400,
      fontFamily: 'NunitoSans',
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.none,
      fontSize: 16.0);
}
