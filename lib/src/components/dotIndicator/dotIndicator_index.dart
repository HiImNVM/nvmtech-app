import 'package:flutter/widgets.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    @required this.index,
    @required this.length,
    this.defaultColorDot = const Color.fromRGBO(0, 0, 4, 0.4),
    this.selectedColorDot = const Color.fromRGBO(0, 0, 0, 0.9),
    this.width = 8,
    this.height = 8,
    this.margin = const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
    this.shape = BoxShape.circle,
  })  : assert(index != null && index > -1),
        assert(length != null && length > -1),
        assert(defaultColorDot != null),
        assert(selectedColorDot != null),
        assert(width != null),
        assert(height != null),
        assert(margin != null),
        assert(shape != null);

  final Color defaultColorDot;
  final Color selectedColorDot;
  final int index;
  final int length;
  final double width;
  final double height;
  final EdgeInsets margin;
  final BoxShape shape;

  List<Widget> _renderDots() {
    List<Widget> dots = [];

    for (int i = 0; i < this.length; ++i) {
      dots.add(Container(
        width: this.width,
        height: this.height,
        margin: this.margin,
        decoration: BoxDecoration(
            shape: this.shape,
            color:
                this.index == i ? this.selectedColorDot : this.defaultColorDot),
      ));
    }

    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: this._renderDots(),
    );
  }
}
