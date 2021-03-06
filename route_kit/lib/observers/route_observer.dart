import 'package:flutter/widgets.dart';
import 'package:route_kit/route/flutter_route.dart';
import 'package:route_kit/route/route.dart';

class LHRouteObserver extends RouteObserver {
  static final LHRouteObserver instance = LHRouteObserver._internal();

  LHRouteObserver._internal();

  List<LHFlutterRoute> routes = [];

  LHPageRoute? get topRoute => routes.isEmpty ? null : routes.last.routeDefinition;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (route is LHFlutterRoute) {
      routes.remove(route);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is LHFlutterRoute) {
      routes.add(route as LHFlutterRoute);
    }
  }
}