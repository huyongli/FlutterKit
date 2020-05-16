import 'package:flutter/material.dart';

class ShareDataWidget extends InheritedWidget {
  final int data; // 子树中共享的数据

  ShareDataWidget({
    @required this.data,
    Widget child
  }): super(child: child);

  static ShareDataWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  /// data发生变化时，该回调决定是否通知子树中依赖data的widget
  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    /// 如果返回true，则子树中依赖(build函数中有调用)本Widget的子widget的{state.didChangeDependencies}会被调用
    return oldWidget.data != data;
  }
}