import 'package:flutter/widgets.dart';
import 'package:route_kit/route/flutter_route.dart';
import 'package:route_kit/route/route.dart';
import 'package:route_kit/navigator.dart';
import 'package:route_kit/observers/route_observer.dart';

class LHRoutePushObserver {
  Future<void> onBeforePush(BuildContext context, LHPageRoute route) {
    throw UnimplementedError('onBeforePush unimplemented');
  }

  Future<void> onAfterPush(BuildContext context, LHPageRoute route) {
    throw UnimplementedError('onBeforePush unimplemented');
  }
}

class DefaultLHRoutePushObserver implements LHRoutePushObserver {
  List<LHFlutterRoute> _removeRoutes = [];
  late bool _isExistDeepLimit;

  void _checkState() {
    _isExistDeepLimit = LHNavigator.routes.values.where((element) {
      return element is LHPageRoute && element.deepLimit != null;
    }).isNotEmpty;
  }

  @override
  Future<void> onBeforePush(BuildContext context, LHPageRoute route) {
    _checkState();
    if (!_isExistDeepLimit) {
      return Future.value();
    }
    _removeRoutes.clear();
    Map<RouteDeepLimit, List<LHFlutterRoute>> groupRoutes = <RouteDeepLimit, List<LHFlutterRoute>>{};
    LHFlutterRoute? lastHistoryRoute;
    LHRouteObserver.instance.routes.forEach((historyRoute) {
      if (historyRoute.routeDefinition.deepLimit != null) {
        if (lastHistoryRoute == null || !historyRoute.routeDefinition.deepLimit!.isContinuousRouteLimit ||
            lastHistoryRoute?.routeDefinition.deepLimit == historyRoute.routeDefinition.deepLimit) {
          /// 相邻两个路由是同一个deep group，或当前路由不限制连续路由
          RouteDeepLimit deepLimit = historyRoute.routeDefinition.deepLimit!;
          if (!groupRoutes.containsKey(deepLimit)) {
            groupRoutes[deepLimit] = <LHFlutterRoute>[];
          }
          groupRoutes[deepLimit]?.add(historyRoute);
        } else {
          /// 相邻两个路由不是同一个deep group
          /// 判断非[historyRoute.routeDefinition.deepLimit]且有深度限制的路由是否限制为连续路由
          /// 如果限制为连续路由，则将前面得到的路由组清空(此时已经不连续了)，也就不会进行清除
          /// 如果不限制为连续路由则不做处理，后面只要达到限制深度就会移除
          groupRoutes.keys
              .where((group) => group != historyRoute.routeDefinition.deepLimit && group.isContinuousRouteLimit)
              .toList()
              .forEach((group) => groupRoutes.remove(group));
        }
      } else {
        /// 当前路由没有深度限制
        /// 判断有深度限制的路由是否限制为连续路由
        /// 如果限制为连续路由，则将前面得到的路由组清空(此时已经不连续了)，也就不会进行清除
        /// 如果不限制为连续路由则不做处理，后面只要达到限制深度就会移除
        groupRoutes.keys
            .where((group) => group.isContinuousRouteLimit)
            .toList()
            .forEach((group) => groupRoutes.remove(group));
      }

      groupRoutes.forEach((key, value) {
        int limit = key == route.deepLimit ? key.limit - 1 : key.limit;
        if (value.length > limit) {
          LHFlutterRoute first = value.first;
          value.remove(first);
          _removeRoutes.add(first);
        }
      });
      lastHistoryRoute = historyRoute;
    });
    return Future.value();
  }

  @override
  Future<void> onAfterPush(BuildContext context, LHPageRoute route) {
    if (!_isExistDeepLimit) {
      return Future.value();
    }
    Future.delayed(Duration(milliseconds: 500), () {
      _removeRoutes.forEach((element) {
        Navigator.of(context).removeRoute(element as Route);
        LHRouteObserver.instance.routes.remove(element);
      });
      _removeRoutes.clear();
    });
    return Future.value();
  }
}
