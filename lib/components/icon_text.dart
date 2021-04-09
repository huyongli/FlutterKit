import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText({
    Key? key,
    required this.icon,
    required this.text,
    this.direction = AxisDirection.up,
    this.padding = EdgeInsets.zero,
    this.space = 0,
    this.onPressed,
  })  : super(key: key);

  final Widget icon;

  final Text text;

  /// [IconText] padding
  final EdgeInsetsGeometry padding;

  final double space;

  /// icon direction
  final AxisDirection direction;

  final VoidCallback? onPressed;

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

    if (padding.horizontal != 0 && padding.vertical != 0) {
      child = Container(padding: padding, child: child);
    }
    if (onPressed != null) {
      return InkWell(onTap: () => this.onPressed?.call(), child: child);
    } else {
      return child;
    }
  }

  List<Widget> _buildIconText() {
    List<Widget> list;
    switch (direction) {
      case AxisDirection.left:
      case AxisDirection.up:
        list = [icon, SizedBox(height: space), text];
        break;
      case AxisDirection.down:
      case AxisDirection.right:
        list = [text, SizedBox(height: space), icon];
        break;
    }
    return list;
  }
}
