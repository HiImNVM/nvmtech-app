import 'package:flutter/material.dart';

enum ToastState {
  opening,
  open,
  closing,
  closed,
}

enum AnimationTypeToast {
  fadeSlideToUp,
  fadeSlideToLeft,
  fade,
}

class Toast {
  static final Toast _singleton = Toast._internal();
  factory Toast() => _singleton;
  Toast._internal();

  static OverlayEntry _overlayEntry;

  static void show(
    BuildContext context, {
    GestureTapCallback onTab,
    Function(ToastState) listener,
    bool isCircle = false,
    Icon icon = const Icon(Icons.info),
    AnimationTypeToast typeAnimationContent = AnimationTypeToast.fadeSlideToUp,
    double borderRadius = 5,
    Color colorBackground = Colors.blueGrey,
    Text title,
    Text subTitle,
    AlignmentGeometry alignment = Alignment.topCenter,
    Duration duration = const Duration(seconds: 4),
    Color colorContent,
  }) async {
    Toast.dismiss();

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Align(
        alignment: alignment,
        child: ToastWidget(
          title: title,
          subTitle: subTitle,
          duration: duration,
          listener: listener,
          onTab: onTab,
          isCircle: isCircle,
          icon: icon,
          typeAnimationContent: typeAnimationContent,
          borderRadius: borderRadius,
          color: colorBackground,
          textSubTitleColor: colorContent,
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry);
  }

  static void dismiss() async {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }
}

class ToastWidget extends StatefulWidget {
  final Function() finish;
  final GestureTapCallback onTab;
  final Function(ToastState) listener;
  final Duration duration;
  final bool isCircle;
  final Widget icon;
  final AnimationTypeToast typeAnimationContent;
  final double borderRadius;
  final Color color;
  final Text title;
  final Text subTitle;

  final Color textSubTitleColor;

  const ToastWidget(
      {Key key,
      this.finish,
      this.duration = const Duration(seconds: 3),
      this.listener,
      this.isCircle = false,
      this.icon,
      this.onTab,
      this.typeAnimationContent = AnimationTypeToast.fadeSlideToUp,
      this.borderRadius = 5.0,
      this.color = Colors.blueGrey,
      this.textSubTitleColor,
      this.title,
      this.subTitle})
      : super(key: key);

  @override
  ToastWidgetState createState() => ToastWidgetState();
}

class ToastWidgetState extends State<ToastWidget>
    with TickerProviderStateMixin {
  static const HEIGHT_CARD = 55.0;
  static const MARGIN_CARD = 15.0;
  static const ELEVATION_CARD = 2.0;

  AnimationController _controllerScale;
  CurvedAnimation _curvedAnimationScale;

  AnimationController _controllerSize;
  CurvedAnimation _curvedAnimationSize;

  AnimationController _controllerTitle;
  Animation<Offset> _titleSlideUp;

  AnimationController _controllerSubTitle;
  Animation<Offset> _subTitleSlideUp;

  @override
  void initState() {
    _controllerScale =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _curvedAnimationScale =
        CurvedAnimation(parent: _controllerScale, curve: Curves.easeInOut)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controllerSize?.forward();
            }
            if (status == AnimationStatus.dismissed) {
              _notifyListener(ToastState.closed);
              if (widget.finish != null) {
                widget.finish();
              }
            }
          });

    _controllerSize =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controllerTitle?.forward();
            }
            if (status == AnimationStatus.dismissed) {
              _controllerScale?.reverse();
            }
          });
    _curvedAnimationSize =
        CurvedAnimation(parent: _controllerSize, curve: Curves.ease);

    _controllerTitle =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controllerSubTitle?.forward();
            }
            if (status == AnimationStatus.dismissed) {
              _controllerSize?.reverse();
            }
          });

    _titleSlideUp = _buildAnimatedContent(_controllerTitle);

    _controllerSubTitle =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _notifyListener(ToastState.open);
              _startTime();
            }
            if (status == AnimationStatus.dismissed) {
              _controllerTitle?.reverse();
            }
          });

    _subTitleSlideUp = _buildAnimatedContent(_controllerSubTitle);
    super.initState();
    show();
  }

  void show() {
    _notifyListener(ToastState.opening);
    _controllerScale?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: HEIGHT_CARD,
        margin: EdgeInsets.all(MARGIN_CARD),
        child: ScaleTransition(
          scale: _curvedAnimationScale,
          child: _buildToast(),
        ),
      ),
    );
  }

  Widget _buildToast() {
    return Material(
        elevation: ELEVATION_CARD,
        borderRadius: _buildBorderCard(),
        color: widget.color,
        child: InkWell(
            onTap: () {
              if (widget.onTab != null) {
                widget?.onTab();
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[_buildIcon(), _buildContent()],
            )));
  }

  Widget _buildIcon() {
    return Container(
      width: HEIGHT_CARD,
      height: HEIGHT_CARD,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: _buildBorderIcon()),
      child: widget.icon,
    );
  }

  Widget _buildContent() {
    return Flexible(
        child: SizeTransition(
            sizeFactor: _curvedAnimationSize,
            axis: Axis.horizontal,
            child: Padding(
                padding: _buildPaddingContent(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildTitle(),
                      _buildSubTitle(),
                    ]))));
  }

  Widget _buildTitle() {
    return AnimatedBuilder(
      animation: _controllerTitle,
      builder: (_, child) {
        return SlideTransition(
          position: _titleSlideUp,
          child: FadeTransition(
            opacity: _controllerTitle,
            child: child,
          ),
        );
      },
      child: widget.title,
    );
  }

  Widget _buildSubTitle() {
    return AnimatedBuilder(
        animation: _controllerSubTitle,
        builder: (_, child) {
          return SlideTransition(
            position: _subTitleSlideUp,
            child: FadeTransition(
              opacity: _controllerSubTitle,
              child: child,
            ),
          );
        },
        child: widget.subTitle);
  }

  BorderRadiusGeometry _buildBorderIcon() {
    if (widget.isCircle) {
      return BorderRadius.all(Radius.circular(25.0));
    }
    return BorderRadius.only(
      topLeft: Radius.circular(widget.borderRadius),
      bottomLeft: Radius.circular(widget.borderRadius),
    );
  }

  BorderRadiusGeometry _buildBorderCard() {
    if (widget.isCircle) {
      return BorderRadius.all(Radius.circular(25.0));
    }
    return BorderRadius.all(Radius.circular(widget.borderRadius));
  }

  EdgeInsets _buildPaddingContent() {
    if (widget.isCircle) {
      return EdgeInsets.only(left: 15.0, right: 25.0);
    }
    return EdgeInsets.only(left: 15.0, right: 15.0);
  }

  Animation<Offset> _buildAnimatedContent(AnimationController controller) {
    double dx = 0.0;
    double dy = 0.0;
    switch (widget.typeAnimationContent) {
      case AnimationTypeToast.fadeSlideToUp:
        {
          dy = 2.0;
        }
        break;
      case AnimationTypeToast.fadeSlideToLeft:
        {
          dx = 2.0;
        }
        break;
      case AnimationTypeToast.fade:
        {}
        break;
    }
    return new Tween(begin: Offset(dx, dy), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));
  }

  void _notifyListener(ToastState state) {
    if (widget.listener != null) {
      widget.listener(state);
    }
  }

  void _startTime() {
    Future.delayed(widget.duration, () {
      _notifyListener(ToastState.closing);
      _controllerSubTitle?.reverse();
    });
  }

  @override
  void dispose() {
    _controllerScale?.dispose();
    _controllerSize?.dispose();
    _controllerTitle?.dispose();
    _controllerSubTitle?.dispose();
    super.dispose();
  }
}
