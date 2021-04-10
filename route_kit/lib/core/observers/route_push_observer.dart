import 'package:flutter/widgets.dart';
import 'package:route_kit/core/definition/flutter_route.dart';
import 'package:route_kit/core/definition/route.dart';
import 'package:route_kit/core/navigator.dart';
import 'package:route_kit/core/observers/route_observer.dart';

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
    Map<RouteDeepLimit, List<LHFlutterRoute>> stackRoutes = <RouteDeepLimit, List<LHFlutterRoute>>{};
    LHRouteObserver.instance.routes.forEach((element) {
      if (element.routeDefinition.deepLimit != null) {
        RouteDeepLimit deepLimit = element.routeDefinition.deepLimit!;
        if (!stackRoutes.containsKey(deepLimit)) {
          stackRoutes[deepLimit] = <LHFlutterRoute>[];
        }
        stackRoutes[deepLimit]?.add(element);
      } else {
        /// 当前路由没有深度限制
        /// 判断有深度限制的路由是否限制为连续路由
        /// 如果限制为连续路由，则将前面得到的路由组清空(此时已经不连续了)，也就不会进行清除
        /// 如果不限制为连续路由则不做处理，后面只要达到限制深度就会移除
        List<RouteDeepLimit> continuousLimit =
            stackRoutes.keys.where((element) => element.isContinuousRouteLimit).toList();
        continuousLimit.forEach((element) {
          stackRoutes.remove(element);
        });
      }

      stackRoutes.forEach((key, value) {
        int limit = key == route.deepLimit ? key.limit - 1 : key.limit;
        if (value.length > limit) {
          LHFlutterRoute first = value.first;
          value.remove(first);
          _removeRoutes.add(first);
        }
      });
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
        Navigator.of(context).removeRoute(element);
        LHRouteObserver.instance.routes.remove(element);
      });
      _removeRoutes.clear();
    });
    return Future.value();
  }
}
