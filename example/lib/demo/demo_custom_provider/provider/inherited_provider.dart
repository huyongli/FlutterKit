import 'package:flutter/material.dart';

/// 数据状态提供者，保存数据状态
class InheritedProvider<T> extends InheritedWidget {
  final T data;

  InheritedProvider({@required this.data, Widget child}): super(child: child);

  @override
  bool updateShouldNotify(InheritedProvider oldWidget) {
    /// 每次更新当前状态时，都调用依赖自身的子节点的didChangeDependencies方法
    return true;
  }
}