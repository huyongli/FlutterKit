import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText({
    Key key,
    @required this.icon,
    @required this.text,
    this.direction = AxisDirection.up,
    this.padding,
    this.space,
    this.onPressed,
  })  : assert(icon != null),
        assert(text != null),
        assert(direction != null),
        super(key: key);

  final Widget icon;

  final Text text;

  /// [IconText] padding
  final EdgeInsetsGeometry padding;

  final double space;

  /// icon direction
  final AxisDirection direction;

  final VoidCallback onPressed;

  bool get _isVertical => direction == AxisDirection.up || direction == AxisDirection.down;

  @override
  Widget build(BuildContext context) {
    Widget child = _isVertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildIconText())
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildIconText());

    if (padding != null) {
      child = Container(padding: padding, child: child);
    }

    return InkWell(onTap: () => this.onPressed?.call(), child: child);
  }

  List<Widget> _buildIconText() {
    List<Widget> list;
    switch (direction) {
      case AxisDirection.left:
      case AxisDirection.up:
        list = [icon, SizedBox(height: space ?? 0), text];
        break;
      case AxisDirection.down:
      case AxisDirection.right:
        list = [text, SizedBox(height: space ?? 0), icon];
        break;
    }
    return list;
  }
}
