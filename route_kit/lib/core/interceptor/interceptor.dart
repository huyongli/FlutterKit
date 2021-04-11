import 'package:route_kit/core/route/route.dart';

class LHRouteInterceptor {
  /// 在路由Push之前对路由进行拦截处理
  /// 返回true则代表拦截，不进行路由跳转，返回false则代表不拦截
  Future<bool> isIntercept(LHRoute route, Map<String, dynamic> params) {
    throw UnimplementedError('isIntercept unimplemented');
  }
}