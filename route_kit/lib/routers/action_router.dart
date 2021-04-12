import 'package:flutter/widgets.dart';
import 'package:route_kit/route/route.dart';
import 'package:route_kit/routers/router.dart';

class ActionRouter extends LHRouter<LHActionRoute> {

  @override
  Future<Map<dynamic, dynamic>> push(BuildContext context, LHActionRoute route) {
    return route.execute(context, route.actualParams);
  }
  
  @override
  bool canPush(BuildContext context, LHRoute route) => route is LHActionRoute;

  @override
  bool canPop(BuildContext context) => false;

  @override
  bool pop(BuildContext context, Map<dynamic, dynamic> params) => false;

  @override
  bool popToRoot(BuildContext context) => false;

  @override
  bool popToRoute(BuildContext context, LHRoute route) => false;

  @override
  bool clearRemovable(BuildContext context) => false;

  @override
  bool popRemovable<T extends LHRemovablePageRoute>(BuildContext context) => false;

  @override
  Future<Map<dynamic, dynamic>> pushAndRemoveUtil(BuildContext context, LHActionRoute route, predicate) {
    return Future.value(<dynamic, dynamic>{});
  }
}