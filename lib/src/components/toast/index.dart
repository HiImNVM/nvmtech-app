import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/core/widgets/toast/toast_index.dart';
import 'package:nvmtech/src/modules/login/login_constant.dart';
import 'package:nvmtech/src/styles/color_style.dart';

void showToastSuccess(BuildContext context) {
  Color textColor = AppColor.MEDIUM_GREEN_SUCCESS_TEXT;
  Color backgroundColor = AppColor.DARK_GREEN_SUCCESS_ICON_BG;
  Toast.show(context,
    icon:  Icon(Icons.check, color: textColor),
    title: Text(
      CONST_SUCCESS_TITLE,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    subTitle: Text(
      CONST_SUCCESS_SUBTITLE,
      style: TextStyle(
        color: textColor
      ),
    ),
    colorBackground: backgroundColor,
  );
}

void showToastError(BuildContext context) {
  Color textColor = AppColor.MEDIUM_RED_ERROR_TEXT;
  Color backgroundColor = AppColor.DARK_RED_ERROR_ICON_BG;
  Toast.show(context,
    icon:  Icon(Icons.check, color: textColor),
    title: Text(
      CONST_ERROR_TITLE,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    subTitle: Text(
      CONST_ERROR_SUBTITLE,
      style: TextStyle(
        color: textColor
      ),
    ),
    colorBackground: backgroundColor,
  );
}

void showToastInfo(BuildContext context) {
  Color textColor = AppColor.MEDIUM_GREY_INFO_TEXT;
  Color backgroundColor = AppColor.DARK_GREY_INFO_ICON_BG;
  Toast.show(context,
    icon:  Icon(Icons.check, color: textColor),
    title: Text(
      CONST_INFO_TITLE,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    subTitle: Text(
      CONST_INFO_TITLE,
      style: TextStyle(
        color: textColor
      ),
    ),
    colorBackground: backgroundColor,
  );
}
