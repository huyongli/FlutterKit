import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:route_kit/route/flutter_route.dart';
import 'package:route_kit/route/route.dart';
import 'package:route_kit/interceptor/interceptor.dart';
import 'package:route_kit/observers/route_push_observer.dart';
import 'package:route_kit/observers/route_observer.dart';
import 'package:route_kit/routers/flutter_router.dart';
import 'package:route_kit/routers/router.dart';

class LHNavigator {
  static bool isDebug = !kReleaseMode;

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

  /// 主页路由
  static late LHPageRoute _homeRoute;

  static LHPageRoute get homeRoute => _homeRoute;

  /// 当push的为未注册的路由时
  /// 1. 该值不为null，则会跳转到对应的页面上去
  /// 2. 如果该值为null，则会停止跳转
  static LHPageRoute? _unknownRoute;

  /// 当前栈顶路由
  static LHPageRoute? get topRoute => LHRouteObserver.instance.topRoute;

  static Widget getHomePage(BuildContext context) {
    assert(routes.isNotEmpty);
    return homeRoute.builder.call(context, homeRoute.actualParams);
  }

  static void registerRoutes({required List<LHRoute> routes, LHPageRoute? homeRoute, LHPageRoute? unknownRoute}) {
    Map<String, LHRoute> routeMaps = routes.fold(<String, LHRoute>{}, (previousValue, element) {
      if (previousValue.containsKey(element.name)) {
        throw AssertionError('Duplicate definition route name for \'${element.name}\'');
      }
      previousValue[element.name] = element;
      return previousValue;
    });
    if (homeRoute == null && (!routeMaps.containsKey('/') || routeMaps['/'] is! LHPageRoute)) {
      throw AssertionError('The main route is not registered');
    }
    _homeRoute = homeRoute ?? routeMaps['/'] as LHPageRoute;
    if (!routeMaps.containsKey(_homeRoute.name)) {
      routeMaps[_homeRoute.name] = _homeRoute;
    }
    _unknownRoute = unknownRoute;
    _routes = Map.unmodifiable(routeMaps);
  }

  static void registerRouteSchema(List<String> schemas) {
    _routeSchemas.addAll(schemas);
  }

  static void registerInterceptor(List<LHRouteInterceptor> interceptors) {
    _interceptors.addAll(interceptors);
  }

  static void registerRoutePushObserver(List<LHRoutePushObserver> observers) {
    _routePushObservers.addAll(observers);
  }

  static void registerRouteObserver(List<NavigatorObserver> observers) {
    _routeObservers.addAll(observers);
  }

  static void registerNavigateRouters(List<LHRouter> routers) {
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
  static Future<Map<dynamic, dynamic>> pushName(BuildContext context, String routeName,
      {Map<String, dynamic>? params}) {
    if (!_routes.containsKey(routeName)) {
      return _handleUnknownRoute(context, 'Route: \'$routeName\' was not found');
    }
    LHRoute route = _routes[routeName]!;
    route.params.clear();
    route.params.addAll(params ?? <String, dynamic>{});
    return push(context, route);
  }

  /// [routeUrl] 参数为[Uri] Schema格式的路由链接
  /// 示例：https://host/path
  static Future<Map<dynamic, dynamic>> pushUrl(BuildContext context, String routeUrl, {Map<String, dynamic>? params}) {
    Map<String, dynamic> newParams = params ?? <String, dynamic>{};

    Uri uri = Uri.parse(routeUrl);
    uri.queryParameters.forEach((key, value) {
      newParams[key] = value;
    });
    if (_routeSchemas.isEmpty) {
      return pushName(context, uri.path, params: newParams);
    }
    String schema = _routeSchemas.firstWhere((element) => routeUrl.startsWith(RegExp(element)), orElse: () => '');
    if (schema.isEmpty) {
      return _handleUnknownRoute(context, 'Route: \'$routeUrl\' not start width \'$_routeSchemas\'');
    }
    return pushName(context, uri.path, params: newParams);
  }

  static Future<bool> _isInterceptRoute(LHRoute route) async {
    List<bool> values = await Future.wait(_interceptors.map((e) => e.isIntercept(route, route.params)));
    return values.contains(true);
  }

  static Future<Map<dynamic, dynamic>> _handleUnknownRoute(BuildContext context, String unknownMsg) {
    if (_unknownRoute != null) {
      return push(context, _unknownRoute!);
    }
    if (isDebug) {
      throw ArgumentError(unknownMsg);
    }
    return Future.value(<dynamic, dynamic>{});
  }

  static bool canPop(BuildContext context) {
    return _navigateRouters.fold(false, (previousValue, element) => previousValue || element.canPop(context));
  }

  static void pop(BuildContext context, {Map<dynamic, dynamic> params = const {}}) {
    for (var router in _navigateRouters) {
      if (router.pop(context, params)) {
        return;
      }
    }
  }

  static void popToRoute(BuildContext context, LHPageRoute route) {
    for (var router in _navigateRouters) {
      if (router.popToRoute(context, route)) {
        return;
      }
    }
  }

  static void popRemovable<T extends LHRemovablePageRoute>(BuildContext context) {
    for (var router in _navigateRouters) {
      if (router.popRemovable<T>(context)) {
        return;
      }
    }
  }

  static void clearRemovable(BuildContext context) {
    popRemovable<LHRemovablePageRoute>(context);
  }
}
