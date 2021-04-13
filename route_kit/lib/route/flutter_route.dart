import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:route_kit/route/route.dart';
import 'package:route_kit/transition/transition.dart';

typedef LHRoutePredicate = bool Function(LHFlutterRoute route);

mixin LHFlutterRoute {
  LHPageRoute get routeDefinition;

  LHFlutterRouteSettings get routeSettings;
}

class LHFlutterRouteSettings extends RouteSettings {
  static int _id = 0;

  final String id;

  LHFlutterRouteSettings({required String name, required Map<String, dynamic> params})
      : id = (++_id).toString(),
        super(name: name, arguments: params);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'LHPageRouteSettings')}("$name", "$id", $arguments)';
  }
}

class LHMaterialPageRoute extends MaterialPageRoute<Map<dynamic, dynamic>> with LHFlutterRoute {
  final LHPageRoute _routeDefinition;

  LHMaterialPageRoute({required LHPageRoute routeDefinition, required WidgetBuilder builder})
      : _routeDefinition = routeDefinition,
        super(
          builder: builder,
          fullscreenDialog: routeDefinition.transition.transitionType == TransitionType.materialFullScreenDialog,
          settings: LHFlutterRouteSettings(name: routeDefinition.name, params: routeDefinition.params),
        );

  @override
  LHPageRoute get routeDefinition => _routeDefinition;

  @override
  LHFlutterRouteSettings get routeSettings => settings as LHFlutterRouteSettings;
}

class LHCupertinoPageRoute extends CupertinoPageRoute<Map<dynamic, dynamic>> with LHFlutterRoute {
  final LHPageRoute _routeDefinition;

  LHCupertinoPageRoute({required LHPageRoute routeDefinition, required WidgetBuilder builder})
      : _routeDefinition = routeDefinition,
        super(
          builder: builder,
          fullscreenDialog: routeDefinition.transition.transitionType == TransitionType.cupertinoFullScreenDialog,
          settings: LHFlutterRouteSettings(name: routeDefinition.name, params: routeDefinition.params),
        );

  @override
  LHPageRoute get routeDefinition => _routeDefinition;

  @override
  LHFlutterRouteSettings get routeSettings => settings as LHFlutterRouteSettings;
}

const _defaultTransitionDuration = const Duration(milliseconds: 250);
class LHPageRouteBuilder extends PageRouteBuilder<Map<dynamic, dynamic>> with LHFlutterRoute {
  final LHPageRoute _routeDefinition;

  LHPageRouteBuilder({required LHPageRoute routeDefinition, required WidgetBuilder builder})
      : _routeDefinition = routeDefinition,
        super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return builder(context);
          },
          settings: LHFlutterRouteSettings(name: routeDefinition.name, params: routeDefinition.params),
          transitionDuration: routeDefinition.transition.transitionDuration ?? _defaultTransitionDuration,
          reverseTransitionDuration: routeDefinition.transition.reverseTransitionDuration ?? _defaultTransitionDuration,
        );

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return routeDefinition.transition.routeTransitionsBuilder(context, animation, secondaryAnimation, child);
  }

  @override
  LHPageRoute get routeDefinition => _routeDefinition;

  @override
  LHFlutterRouteSettings get routeSettings => settings as LHFlutterRouteSettings;
}

extension LHRouteTransitionExt on LHRouteTransition {
  RouteTransitionsBuilder get routeTransitionsBuilder {
    return (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      late Widget widget;
      switch (this.transitionType) {
        case TransitionType.custom:
          widget = transitionsBuilder!.call(context, animation, secondaryAnimation, child);
          break;
        case TransitionType.fadeIn:
          widget = FadeTransition(opacity: animation, child: child);
          break;
        case TransitionType.scale:
          widget = ScaleTransition(scale: animation, child: child);
          break;
        case TransitionType.rotationScale:
          widget = RotationTransition(turns: animation, child: ScaleTransition(scale: animation, child: child));
          break;
        case TransitionType.inFromBottom:
        case TransitionType.inFromLeft:
        case TransitionType.inFromRight:
        case TransitionType.inFromTop:
          widget = _directionTransitionWidget(animation, child);
          break;
        case TransitionType.none:
          widget = child;
          break;
        default:
          throw StateError('Not support custom transition');
      }
      return widget;
    };
  }

  Widget _directionTransitionWidget(Animation<double> animation, Widget child) {
    const Offset topLeft = const Offset(0.0, 0.0);
    const Offset topRight = const Offset(1.0, 0.0);
    const Offset bottomLeft = const Offset(0.0, 1.0);
    Offset startOffset = bottomLeft;
    Offset endOffset = topLeft;

    if (transitionType == TransitionType.inFromLeft) {
      startOffset = const Offset(-1.0, 0.0);
      endOffset = topLeft;
    } else if (transitionType == TransitionType.inFromRight) {
      startOffset = topRight;
      endOffset = topLeft;
    } else if (transitionType == TransitionType.inFromBottom) {
      startOffset = bottomLeft;
      endOffset = topLeft;
    } else if (transitionType == TransitionType.inFromTop) {
      startOffset = Offset(0.0, -1.0);
      endOffset = topLeft;
    }
    return SlideTransition(
      position: Tween<Offset>(begin: startOffset, end: endOffset).animate(animation),
      child: child,
    );
  }
}
