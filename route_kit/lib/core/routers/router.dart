import 'package:flutter/material.dart';
import 'package:route_kit/core/route/flutter_route.dart';
import 'package:route_kit/core/route/route.dart';

abstract class LHRouter<T extends LHRoute> {

  Future<Map<dynamic, dynamic>> push(BuildContext context, T route);

  Future<Map<dynamic, dynamic>> pushAndRemoveUtil(BuildContext context, T route, LHRoutePredicate predicate);

  bool canPop(BuildContext context);
  
  bool canPush(BuildContext context, LHRoute route);

  bool pop(BuildContext context, Map<dynamic, dynamic> params);

  bool popToRoute(BuildContext context, LHRoute route);

  bool popToRoot(BuildContext context);

  bool popRemovable<T extends LHRemovablePageRoute>(BuildContext context);

  bool clearRemovable(BuildContext context);
}
