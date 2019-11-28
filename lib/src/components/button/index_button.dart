import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/src/styles/color_style.dart';

class AppButton extends StatelessWidget {
  AppButton({
    this.onPressed,
    this.child,
    this.color,
  });
  final Function() onPressed;
  final Widget child;
  final color;
  
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50, minWidth: double.infinity,
      color: color,
      textColor: Colors.white,
      child: child,
      onPressed: this.onPressed,
    );
  }
}
