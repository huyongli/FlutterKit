import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:route_kit/core/definition/flutter_route.dart';

import 'package:route_kit/core/definition/route.dart';
import 'package:route_kit/core/interceptor/interceptor.dart';
import 'package:route_kit/core/observers/route_push_observer.dart';
import 'package:route_kit/core/observers/route_observer.dart';
import 'package:route_kit/core/routers/flutter_router.dart';
import 'package:route_kit/core/routers/router.dart';
import 'package:route_kit/route_kit.dart';

class LHNavigator {
  static bool isDebug = !kReleaseMode;

  /// 当push的为未注册的路由时
  /// 1. 该值不为null，则会跳转到对应的页面上去
  /// 2. 如果该值为null，则会停止跳转
  static LHPageRoute? unknownRoute;

  /// 路由schema头
  static List<String> _routeSchemas = [];

  /// 路由Push之前的拦截器
  static List<LHRouteInterceptor> _interceptors = [];

  /// 路由Push前后监测
  static List<LHRoutePushObserver> _routePushObservers = [DefaultLHRoutePushObserver()];

  static List<LHRoutePushObserver> get routePushObservers => _routePushObservers;

  static List<NavigatorObserver> _routeObservers = [LHRouteObserver.instance];

  static List<NavigatorObserver> get routeObservers => _routeObservers;

  static List<LHRouter> _navigateRouters = [FlutterRouter()];

  /// 路由注册表
  static late Map<String, LHRoute> _routes;

  static Map<String, LHRoute> get routes => _routes;

  /// 当前栈顶路由
  LHPageRoute? get topRoute => LHRouteObserver.instance.topRoute;

  void registerRoutes(List<LHRoute> routes) {
    Map<String, LHRoute> routeMaps = routes.fold(<String, LHRoute>{}, (previousValue, element) {
      if (previousValue.containsKey(element.name)) {
        throw ArgumentError('Duplicate definition route name for \'${element.name}\'');
      }
      previousValue[element.name] = element;
      return previousValue;
    });
    _routes = Map.unmodifiable(routeMaps);
  }

  void registerRouteSchema(List<String> schemas) {
    _routeSchemas.addAll(schemas);
  }

  void registerInterceptor(List<LHRouteInterceptor> interceptors) {
    _interceptors.addAll(interceptors);
  }

  void registerRoutePushObserver(List<LHRoutePushObserver> observers) {
    _routePushObservers.addAll(observers);
  }

  void registerRouteObserver(List<NavigatorObserver> observers) {
    _routeObservers.addAll(observers);
  }

  void registerNavigateRouters(List<LHRouter> routers) {
    _navigateRouters.addAll(routers);
  }

  static Future<Map<dynamic, dynamic>> push(BuildContext context, LHRoute route) async {
    bool isIntercept = await _isInterceptRoute(route);
    if (isIntercept) {
      return Future.value(<dynamic, dynamic>{});
    }
    try {
      LHRouter router = _navigateRouters.firstWhere((element) => element.canPush(context, route));
      return router.push(context, route);
    } catch (e) {
      throw StateError('No registered route handles \'$route\'');
    }
  }

  static Future<Map<dynamic, dynamic>> pushAndRemoveUtil(
    BuildContext context,
    LHRoute route,
    LHRoutePredicate predicate,
  ) async {
    bool isIntercept = await _isInterceptRoute(route);
    if (isIntercept) {
      return Future.value(<dynamic, dynamic>{});
    }
    try {
      LHRouter router = _navigateRouters.firstWhere((element) => element.canPush(context, route));
      return router.pushAndRemoveUtil(context, route, predicate);
    } catch (e) {
      throw StateError('No registered route handles \'$route\'');
    }
  }

  /// [routeName] 参数对应 [Route.name] 的值
  static Future<Map<dynamic, dynamic>> pushName(BuildContext context, String routeName, Map<String, dynamic> params) {
    if (!_routes.containsKey(routeName)) {
      return _handleUnknownRoute(context, 'Route: \'$routeName\' is not registered');
    }
    LHRoute route = _routes[routeName]!;
    route.params.addAll(params);
    return push(context, route);
  }

  /// [routeUrl] 参数为[Uri] Schema格式的路由链接
  /// 示例：https://host/path
  static Future<Map<dynamic, dynamic>> pushUrl(BuildContext context, String routeUrl, Map<String, dynamic> params) {
    if (_routeSchemas.isEmpty) {
      return pushName(context, routeUrl, params);
    }
    String schema = _routeSchemas.firstWhere((element) => routeUrl.startsWith(RegExp(element)), orElse: () => '');
    if (schema.isEmpty) {
      return _handleUnknownRoute(context, 'Route: \'$routeUrl\' not start width \'$_routeSchemas\'');
    }
    Uri uri = Uri.parse(routeUrl);
    uri.queryParameters.forEach((key, value) {
      params[key] = value;
    });
    return pushName(context, uri.path, params);
  }

  static Future<bool> _isInterceptRoute(LHRoute route) async {
    List<bool> values = await Future.wait(_interceptors.map((e) => e.isIntercept(route, route.params)));
    return values.contains(true);
  }

  static Future<Map<dynamic, dynamic>> _handleUnknownRoute(BuildContext context, String unknownMsg) {
    if (unknownRoute != null) {
      return push(context, unknownRoute!);
    }
    if (isDebug) {
      throw ArgumentError(unknownMsg);
    }
    return Future.value(<dynamic, dynamic>{});
  }

  bool canPop(BuildContext context) {
    return _navigateRouters.fold(false, (previousValue, element) => previousValue || element.canPop(context));
  }

  void pop(BuildContext context, Map<dynamic, dynamic> params) {
    for (var router in _navigateRouters) {
      if (router.pop(context, params)) {
        return;
      }
    }
  }

  void popToRoute(BuildContext context, LHPageRoute route) {
    for (var router in _navigateRouters) {
      if (router.popToRoute(context, route)) {
        return;
      }
    }
  }

  void popRemovable<T extends LHRemovablePageRoute>(BuildContext context) {
    for (var router in _navigateRouters) {
      if (router.popRemovable<T>(context)) {
        return;
      }
    }
  }

  void clearRemovable(BuildContext context) {
    popRemovable<LHRemovablePageRoute>(context);
  }
}
