import 'package:route_kit/core/definition/route.dart';

class RoutePushListener {
  Future<void> onBeforePush(BaseRoute route) {
    return Future.value();
  }

  Future<void> onAfterPush(BaseRoute route) {
    return Future.value();
  }
}