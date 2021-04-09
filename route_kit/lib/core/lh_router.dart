import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:route_kit/core/definition/route.dart';
import 'package:route_kit/core/interceptor/interceptor.dart';

class LHRouter {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static bool isDebug = !kReleaseMode;

  /// 当push的为未注册的路由时
  /// 1. 该值不为null，则会跳转到对应的页面上去
  /// 2. 如果该值为null，则会停止跳转
  static BaseRoute? unknownRoute;

  /// 路由schema头
  static List<String> _routeSchemas = [];

  static List<RouteInterceptor> _interceptors = [];

  /// 路由注册表
  static late Map<String, BaseRoute> _routes;

  static Map<String, BaseRoute> get routes => _routes;

  void registerRoutes(List<BaseRoute> routes) {
    Map<String, BaseRoute> routeMaps = routes.fold(<String, BaseRoute>{}, (previousValue, element) {
      previousValue[element.route] = element;
      return previousValue;
    });
    _routes = Map.unmodifiable(routeMaps);
  }

  void registerRouteSchema(List<String> schemas) {
    _routeSchemas.addAll(schemas);
  }

  void registerInterceptors(List<RouteInterceptor> interceptors) {
    _interceptors.addAll(interceptors);
  }

  static Future<Map<dynamic, dynamic>> push(BuildContext context, BaseRoute route) async {
    bool isIntercept = await isInterceptRoute(route);
    if (isIntercept) {
      return Future.value(<dynamic, dynamic>{});
    }
    return Future.value();
  }

  /// [route] 参数对应 [BaseRoute.route] 的值
  static Future<Map<dynamic, dynamic>> pushPath(BuildContext context, String route, Map<String, dynamic> params) {
    if (!_routes.containsKey(route)) {
      return _handleUnknownRoute(context, 'Route: \'$route\' not registered');
    }
    BaseRoute baseRoute = _routes[route]!;
    baseRoute.params.addAll(params);
    return push(context, baseRoute);
  }

  /// [routeUrl] 参数为[Uri] Schema格式的路由链接
  /// 示例：https://host/path
  static Future<Map<dynamic, dynamic>> pushUrl(BuildContext context, String routeUrl, Map<String, dynamic> params) {
    if (_routeSchemas.isEmpty) {
      return pushPath(context, routeUrl, params);
    }
    String schema = _routeSchemas.firstWhere((element) => routeUrl.startsWith(RegExp(element)), orElse: () => '');
    if (schema.isEmpty) {
      return _handleUnknownRoute(context, 'Route: \'$routeUrl\' not start width \'$_routeSchemas\'');
    }
    Uri uri = Uri.parse(routeUrl);
    uri.queryParameters.forEach((key, value) {
      params[key] = value;
    });
    return pushPath(context, uri.path, params);
  }

  static Future<bool> isInterceptRoute(BaseRoute route) async {
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
}
