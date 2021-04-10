import 'package:flutter/widgets.dart';
import 'package:route_kit/core/definition/flutter_route.dart';
import 'package:route_kit/core/definition/route.dart';
import 'package:route_kit/core/navigator.dart';
import 'package:route_kit/core/observers/route_observer.dart';
import 'package:route_kit/core/routers/router.dart';

class FlutterRouter extends LHRouter<LHPageRoute> {

  @override
  Future<Map<dynamic, dynamic>> push(BuildContext context, LHPageRoute route) async {
    await Future.wait(LHNavigator.routePushObservers.map((e) => e.onBeforePush(context, route)));

    LHFlutterRoute flutterRoute = LHFlutterRoute(
      routeDefinition: route,
      builder: (BuildContext context) => route.builder(context, route.actualParams),
    );

    Map<dynamic, dynamic>? result = await Navigator.of(context).push(flutterRoute);

    await Future.wait(LHNavigator.routePushObservers.map((e) => e.onAfterPush(context, route)));

    return Future.value(result ?? <dynamic, dynamic>{});
  }

  @override
  Future<Map<dynamic, dynamic>> pushAndRemoveUtil(BuildContext context, LHPageRoute route,
      LHRoutePredicate predicate) async {
    await Future.wait(LHNavigator.routePushObservers.map((e) => e.onBeforePush(context, route)));

    LHFlutterRoute flutterRoute = LHFlutterRoute(
      routeDefinition: route,
      builder: (BuildContext context) => route.builder(context, route.actualParams),
    );

    Map<dynamic, dynamic>? result = await Navigator.of(context).pushAndRemoveUntil(
        flutterRoute, (route) => predicate.call(flutterRoute));

    await Future.wait(LHNavigator.routePushObservers.map((e) => e.onAfterPush(context, route)));

    return Future.value(result ?? <dynamic, dynamic>{});
  }

  @override
  bool canPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }

  @override
  bool pop(BuildContext context, Map<dynamic, dynamic> params) {
    Navigator.of(context).pop(params);
    return true;
  }

  @override
  bool popToRoute(BuildContext context, LHRoute route) {
    try {
      LHFlutterRoute flutterRoute = LHRouteObserver.instance.routes.firstWhere((element) {
        return element.routeDefinition == route;
      });
      Navigator.of(context).popUntil((predicate) => predicate == flutterRoute);
      return true;
    } catch (e) {
      /// 路由栈中没有要显示的路由
      return false;
    }
  }

  @override
  bool popToRoot(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    return true;
  }

  @override
  bool canPush(BuildContext context, LHRoute route) => route is LHPageRoute;

  @override
  bool popRemovable<T extends LHRemovablePageRoute>(BuildContext context) {
    LHRouteObserver.instance.routes.where((element) => element is T).forEach((element) {
      Navigator.of(context).removeRoute(element);
    });
    return true;
  }

  @override
  bool clearRemovable(BuildContext context) {
    return popRemovable<LHRemovablePageRoute>(context);
  }
}
