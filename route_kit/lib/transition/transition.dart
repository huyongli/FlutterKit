import 'package:flutter/widgets.dart';

class LHRouteTransition {
  static const defaultTransitionDuration = const Duration(milliseconds: 300);

  final TransitionType transitionType;
  final RouteTransitionsBuilder? transitionsBuilder;
  final Duration transitionDuration;
  final Duration reverseTransitionDuration;

  LHRouteTransition({
    this.transitionType = TransitionType.native,
    this.transitionsBuilder,
    Duration transitionDuration = defaultTransitionDuration,
    Duration reverseTransitionDuration = defaultTransitionDuration,
  })  : assert(transitionType != TransitionType.custom || transitionsBuilder != null),
        this.transitionDuration = transitionType == TransitionType.none ? Duration.zero : transitionDuration,
        this.reverseTransitionDuration =
            transitionType == TransitionType.none ? Duration.zero : reverseTransitionDuration;
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
  material,
  materialFullScreenDialog,
  cupertino,
  cupertinoFullScreenDialog,
}
