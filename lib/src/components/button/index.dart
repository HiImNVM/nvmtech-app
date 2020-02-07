import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';

class AppButton extends StatelessWidget {
  AppButton({
    this.onPressed,
    this.child,
    this.color,
    this.padding,
    this.height = 50,
    this.isShadow = false,
  });
  final Function() onPressed;
  final Widget child;
  final color;
  final double height;
  final EdgeInsetsGeometry padding;
  final bool isShadow;

  static Widget renderTextInButton(String text) {
    return Text(
      text,
      style: AppTextStyle.WHITE_W700_F16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      disabledColor: Color(0xff595959),
      padding: padding,
      height: height,
      minWidth: double.infinity,
      color: color,
      textColor: Colors.white,
      child: child,
      onPressed: this.onPressed,
      elevation: this.isShadow ? 8 : 2,
    );
  }
}
