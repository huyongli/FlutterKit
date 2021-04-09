import 'package:route_kit/core/definition/route.dart';
import 'package:route_kit/core/lh_router.dart';

class RouteInterceptor {
  /// 在路由Push之前对路由进行拦截处理
  /// 返回true则代表拦截，不进行路由跳转，返回false则代表不拦截
  Future<bool> isIntercept(BaseRoute route, Map<String, dynamic> params) {
    throw UnimplementedError('isIntercept unimplemented');
  }
}

class DefaultRouteInterceptor implements RouteInterceptor {

  @override
  Future<bool> isIntercept(BaseRoute route, Map<String, dynamic> params) async {
    if (!LHRouter.routes.containsKey(route.route)) {
      if (LHRouter.unknownRoute != null) {

      }
    }
    return false;
  }

}