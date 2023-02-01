import 'package:flutter/material.dart';

import 'inherited_provider.dart';

/// T is data model
class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget child;
  final T data;

  ChangeNotifierProvider({super.key, required this.data, required this.child});

  static T? of<T>(BuildContext context, {bool listen = true}) {
    final provider = listen ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context.getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()?.widget as InheritedProvider<T>;
    return provider?.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() => _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {

  @override
  void initState() {
    widget.data.addListener(update);
    super.initState();
  }

  void update() => setState(() {});

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    /// provider更新时，如果新旧数据不相等，则解绑旧数据监听，同时添加新数据的监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    super.dispose();
  }
}
