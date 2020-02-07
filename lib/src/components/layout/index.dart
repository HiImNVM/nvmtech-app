import 'package:flutter/material.dart';
import 'package:nvmtech/src/styles/margin_style.dart';

class BodyLayout extends StatelessWidget {
  BodyLayout({
    this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(AppDimension.PADDING),
        child: child,
      ),
    );
  }
}
