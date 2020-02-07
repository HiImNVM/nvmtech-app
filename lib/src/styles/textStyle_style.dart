import 'package:flutter/material.dart';
import 'package:nvmtech/src/styles/color_style.dart';

class AppTextStyle {
  static const TextStyle BASE_STYLE = const TextStyle(
    fontFamily: 'NunitoSans',
    fontStyle: FontStyle.normal,
    fontSize: 12,
    decoration: TextDecoration.none,
  );

  static final TextStyle WHITE_W600_F14_H2 = BASE_STYLE.copyWith(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 2,
  );

  static final TextStyle WHITE_W700_F16 = BASE_STYLE.copyWith(
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  static final TextStyle WHITE_W700_F18 = WHITE_W700_F16.copyWith(fontSize: 18);

  static final TextStyle BROWN_GREY_W700_F18 = WHITE_W700_F16.copyWith(
    color: AppColor.BROWN_GREY,
    fontSize: 18,
  );

  static final TextStyle BROWN_GREY_W700_F30 = BROWN_GREY_W700_F18.copyWith(
    fontSize: 30,
  );

  static final TextStyle BROWN_GREY_W600_F12 = BROWN_GREY_W700_F18.copyWith(
    fontSize: 12,
  );

  static final TextStyle BROWN_GREY_W600_F14 = BROWN_GREY_W700_F18.copyWith(
    fontSize: 14,
  );

  static final TextStyle TOPAZ_W600_F12 = BASE_STYLE.copyWith(
    color: AppColor.TOPAZ,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );

  static final TextStyle BLACK_W400_F16 = BASE_STYLE.copyWith(
      color: AppColor.BLACK, fontWeight: FontWeight.w400, fontSize: 16);

  static final TextStyle BLACK_W600_F14 = BLACK_W400_F16.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static final TextStyle BLACK_WBOLD_F30 = BLACK_W400_F16.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
}
