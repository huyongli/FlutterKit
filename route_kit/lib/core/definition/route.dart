import 'package:flutter/widgets.dart';

typedef RouteWidgetBuilder = Widget Function(BuildContext context, Map<String, dynamic> params);

/// 对不断循环出现的路由进行深度限制，超过这个数字之和，将最开始出现的路由进行清除
/// [group]  要进行限制的路由组，可以将多个路由设置为一个组
/// [limit]  该组路由的深度最大值，默认为5，如果一组路由内此值大小不一致，会取最小值
class RouteDeepLimit {
  final String group;
  final int limit;

  RouteDeepLimit({required this.group, this.limit = 5});
}

abstract class BaseRoute {
  String get route;

  /// 路由对应的页面Widget构造器
  RouteWidgetBuilder get builder;

  Map<String, dynamic> params = <String, dynamic>{};

  /// 在调[builder]构造widget之前会先调此方法对参数进行处理
  Map<String, dynamic> paramsHandler(Map<String, dynamic> params) {
    return params;
  }

  /// 不为null时表示此路由页面要进行深度限制
  RouteDeepLimit? get deepLimit => null;
}
