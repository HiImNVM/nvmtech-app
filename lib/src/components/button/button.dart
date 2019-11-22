import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/src/styles/color_style.dart';

class AppButton extends StatelessWidget {
  AppButton({
    this.onPressed,
    this.child,
  });

  final Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColor.MAIN_LINEARGRADIENT,
        borderRadius: BorderRadius.circular(2),
      ),
      child: FlatButton(
        textColor: Colors.white,
        child: child,
        onPressed: this.onPressed,
      ),
    );
  }
}
