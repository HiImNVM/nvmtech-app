import 'package:flutter/material.dart';
import 'package:nvmtech/src/modules/login/pages/login_page.dart';

class PinBox extends StatelessWidget {
  PinBox({
    this.color,
    this.textColor,
    this.width = 70,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.onSubmit,
  });

  final color;
  final double width;
  TextEditingController controller;
  FocusNode nextFocusNode;
  FocusNode focusNode;
  Color textColor;
  final Function onSubmit;

  @override
  Widget build(BuildContext context) {
    void _onChangedNextFocusNode(String text, TextEditingController controller,
        FocusNode nextFocusNode) {
      if (text.length > 1) {
        controller.text = text.substring(text.length - 1);
      }
      if (!nextFocusNode.hasFocus) {
        FocusScope.of(context).requestFocus(nextFocusNode);
      }
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7.0),
      width: width,
      
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          border: InputBorder.none,
        ),
        controller: controller,
        textAlign: TextAlign.center,
        cursorColor: color,
        onChanged: (text) =>
            _onChangedNextFocusNode(text, controller, nextFocusNode),
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        autofocus: false,
        onSubmitted: this.onSubmit
      ),
    );
  }
}
