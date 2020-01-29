import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/core/widgets/toast/toast_index.dart';
import 'package:nvmtech/src/modules/login/constants/login_constant.dart';
import 'package:nvmtech/src/styles/color_style.dart';

void showToastSuccess(BuildContext context, String message) {
  final Color textColor = AppColor.GREEN_SUCCESS;

  Toast.show(
    context,
    icon: Icon(Icons.check, color: textColor),
    title: Text(
      CONST_SUCCESS_TITLE,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
    subTitle: Text(
      message,
      style: TextStyle(
        color: textColor,
        fontSize: 14,
      ),
      overflow: TextOverflow.ellipsis,
    ),
    colorBackground: AppColor.GREEN_SUCCESS_BG,
  );
}

void showToastError(BuildContext context, String message) {
  final Color textColor = AppColor.RED_ERROR;

  Toast.show(
    context,
    icon: Icon(Icons.clear, color: textColor),
    title: Text(
      CONST_ERROR_TITLE,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
    subTitle: Text(
      message,
      style: TextStyle(
        color: textColor,
        fontSize: 14,
      ),
      overflow: TextOverflow.ellipsis,
    ),
    colorBackground: AppColor.RED_ERROR_BG,
  );
}

void showToastInfo(BuildContext context, String message) {
  final Color textColor = AppColor.GREY_INFO;

  Toast.show(
    context,
    icon: Icon(Icons.access_time, color: textColor),
    title: Text(
      CONST_INFO_TITLE,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
    subTitle: Text(
      message,
      style: TextStyle(
        color: textColor,
        fontSize: 14,
      ),
      overflow: TextOverflow.ellipsis,
    ),
    colorBackground: AppColor.GREY_INFO_BG,
  );
}
