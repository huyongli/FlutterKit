import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:route_kit/route/route.dart';

typedef LHRoutePredicate = bool Function(LHFlutterRoute route);

mixin LHFlutterRouteMixin {
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

class LHFlutterRoute extends MaterialPageRoute<Map<dynamic, dynamic>> with LHFlutterRouteMixin {
  final LHPageRoute _routeDefinition;

  LHFlutterRoute({required LHPageRoute routeDefinition, required WidgetBuilder builder})
      : _routeDefinition = routeDefinition,
        super(
          builder: builder,
          settings: LHFlutterRouteSettings(name: routeDefinition.name, params: routeDefinition.params),
        );

  @override
  LHPageRoute get routeDefinition => _routeDefinition;

  @override
  LHFlutterRouteSettings get routeSettings => settings as LHFlutterRouteSettings;
}
