import 'package:flutter/material.dart';

import 'viewmodel/reader_viewmodel.dart';

class ReaderProvider extends InheritedWidget {
  final ReaderViewModel viewModel;

  ReaderProvider({
    Key key,
    Widget child,
    this.viewModel
  }): super(key: key, child: child);

  static ReaderProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ReaderProvider>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}