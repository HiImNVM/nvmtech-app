import 'package:flutter/material.dart';

class Toast {
  static final int LENGTH_SHORT = 1;
  static final int LENGTH_LONG = 2;
  static final int BOTTOM = 0;
  static final int CENTER = 1;
  static final int TOP = 2;

  static void show(String msg, BuildContext context,
      {int duration = 20,
      int gravity = 2,
      Color backgroundColor = const Color(0xAA000000),
      Color textColor = Colors.white,
      Icon icon,
      Color iconRectangleColor,
      double backgroundRadius = 5,
      Border border}) {
    ToastView.dismiss();
    ToastView.createView(msg, context, duration, gravity, backgroundColor,
        textColor, icon, iconRectangleColor, backgroundRadius, border);
  }
}

class ToastView {
  static final ToastView _singleton = ToastView._internal();

  factory ToastView() {
    return _singleton;
  }

  ToastView._internal();

  static OverlayState overlayState;
  static OverlayEntry _overlayEntry;
  static bool _isVisible = false;

  static void createView(
      String msg,
      BuildContext context,
      int duration,
      int gravity,
      Color background,
      Color textColor,
      Icon icon,
      Color iconRectangleColor,
      double backgroundRadius,
      Border border) async {
    overlayState = Overlay.of(context);

    Paint paint = Paint();
    paint.strokeCap = StrokeCap.square;
    paint.color = background;

    double widthToast = MediaQuery.of(context).size.width;

    Widget _renderToastContent() {
      return Row(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: iconRectangleColor,
              ),
              child: icon),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                msg,
                softWrap: true,
                style: TextStyle(
                  fontSize: 15,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      );
    }

    Widget _renderToastLayout() {
      return Container(
          width: widthToast,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: widthToast * 0.035),
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(backgroundRadius),
                border: border,
              ),
              child: _renderToastContent(),
            ),
          ));
    }

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) =>
          _ToastWidget(widget: _renderToastLayout(), gravity: gravity),
    );

    _isVisible = true;
    overlayState.insert(_overlayEntry);
    await Future.delayed(
        Duration(seconds: duration == null ? Toast.LENGTH_SHORT : duration));
    dismiss();
  }

  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

class _ToastWidget extends StatelessWidget {
  _ToastWidget({
    Key key,
    @required this.widget,
    @required this.gravity,
  }) : super(key: key);

  final Widget widget;
  final int gravity;

  @override
  Widget build(BuildContext context) => Positioned(
      top: gravity == 2 ? 50 : null,
      bottom: gravity == 0 ? 50 : null,
      child: Material(
        color: Colors.transparent,
        child: widget,
      ));
}
