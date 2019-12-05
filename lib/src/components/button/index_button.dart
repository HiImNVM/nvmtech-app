import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton({
    this.onPressed,
    this.child,
    this.color,
    this.height = 50,
  });
  final Function() onPressed;
  final Widget child;
  final color;
  final double height;

  static Widget renderTextInButton(String text, TextStyle textstyle) {
    return Text(
      text,
      style: textstyle,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height, 
      minWidth: double.infinity,
      color: color,
      textColor: Colors.white,
      child: child,
      onPressed: this.onPressed,
    );
  }
}