import 'package:flutter/widgets.dart';

typedef RouteWidgetBuilder = Widget Function(BuildContext context, Map<String, dynamic> params);

/// 对不断循环出现的路由进行深度限制，超过指定的深度限制，会将最开始出现的路由进行清除
///
/// 一组路由建议用相同的限制策略
class RouteDeepLimit {
  /// 路由组
  final String group;

  /// 深度限制
  final int limit;

  /// 深度是否为连续不间断
  final bool isContinuousRouteLimit;

  RouteDeepLimit({required this.group, this.limit = 5, this.isContinuousRouteLimit = false});

  @override
  bool operator ==(Object other) {
    return other is RouteDeepLimit && other.group == this.group;
  }

  @override
  int get hashCode => group.hashCode;
}

abstract class LHRoute {
  /// 路由名称，需具备唯一性
  String get name;

  Map<String, dynamic> params = <String, dynamic>{};

  /// 在调[builder]构造widget之前会先调此方法对参数进行处理
  Map<String, dynamic> paramsHandler(Map<String, dynamic> params) {
    return params;
  }

  @override
  bool operator ==(Object other) {
    return other is LHRoute && other.name == this.name;
  }

  @override
  int get hashCode => name.hashCode;
}

abstract class LHPageRoute extends LHRoute {
  /// 路由对应的页面Widget构造器
  RouteWidgetBuilder get builder;

  /// 页面进行深度限制，
  /// 为null则不进行限制
  RouteDeepLimit? get deepLimit => null;
}

extension LHRouteExt on LHRoute {
  Map<String, dynamic> get actualParams => paramsHandler(params);
}

abstract class LHActionRoute extends LHRoute {
  
  Future<Map<dynamic, dynamic>> execute(BuildContext context, Map<String, dynamic> params);
}

abstract class LHRemovablePageRoute extends LHPageRoute {

}