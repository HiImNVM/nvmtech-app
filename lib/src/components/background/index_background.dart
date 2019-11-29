import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvmtech/src/styles/image_style.dart';

class AppBackground extends StatelessWidget {
  AppBackground({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(AppImage.PATH_BACKGROUND_IMAGE),
        ),
      ),
      child: child,
    );
  }
}
