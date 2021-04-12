import 'package:flutter/widgets.dart';

class LHRouteTransition {
  final TransitionType transitionType;
  final RouteTransitionsBuilder? transitionsBuilder;
  final Duration? transitionDuration;
  final Duration? reverseTransitionDuration;

  LHRouteTransition({
    this.transitionType = TransitionType.native,
    this.transitionsBuilder,
    this.transitionDuration,
    this.reverseTransitionDuration,
  })  : assert(transitionType != TransitionType.custom || transitionsBuilder != null);
}

enum TransitionType {
  none,
  native,
  custom,
  inFromLeft,
  inFromTop,
  inFromRight,
  inFromBottom,
  fadeIn,
  scale,
  rotationScale,
  material,
  materialFullScreenDialog,
  cupertino,
  cupertinoFullScreenDialog,
}
