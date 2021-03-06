import 'package:flutter/widgets.dart';
import 'package:route_kit/route/flutter_route.dart';
import 'package:route_kit/route/route.dart';
import 'package:route_kit/navigator.dart';
import 'package:route_kit/observers/route_observer.dart';
import 'package:route_kit/routers/router.dart';

class FlutterRouter extends LHRouter<LHPageRoute> {
  @override
  Future<Map<dynamic, dynamic>> push(BuildContext context, LHPageRoute route) async {
    await Future.wait(LHNavigator.routePushObservers.map((e) => e.onBeforePush(context, route)));

    Map<dynamic, dynamic>? result = await Navigator.of(context).push(route.toFlutterRoute);

    await Future.wait(LHNavigator.routePushObservers.map((e) => e.onAfterPush(context, route)));

    return Future.value(result ?? <dynamic, dynamic>{});
  }

  @override
  Future<Map<dynamic, dynamic>> pushAndRemoveUtil(
      BuildContext context, LHPageRoute route, LHRoutePredicate predicate) async {
    await Future.wait(LHNavigator.routePushObservers.map((e) => e.onBeforePush(context, route)));

    Map<dynamic, dynamic>? result = await Navigator.of(context).pushAndRemoveUntil(
        route.toFlutterRoute, (route) => route is LHFlutterRoute && predicate.call(route as LHFlutterRoute));

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
      Navigator.of(context).popUntil((predicate) => predicate == flutterRoute as Route);
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
    LHRouteObserver.instance.routes.where((element) => element.routeDefinition is T).forEach((element) {
      Navigator.of(context).removeRoute(element as Route);
    });
    return true;
  }

  @override
  bool clearRemovable(BuildContext context) {
    return popRemovable<LHRemovablePageRoute>(context);
  }
}
