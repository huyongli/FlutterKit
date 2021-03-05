import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircleColorWidget extends StatelessWidget {
  final Color color;
  final double radius;

  CircleColorWidget({Color color, double radius})
      : color = color ?? Colors.black,
        radius = radius ?? 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
    );
  }
}
