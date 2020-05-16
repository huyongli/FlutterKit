import 'package:flutter/material.dart';

import 'change_notifier_provider.dart';

class Consumer<T> extends StatelessWidget {
  final Widget child;
  final Widget Function(BuildContext context, T value) builder;

  Consumer({Key key, @required this.builder, this.child}): assert(builder != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context)
    );
  }
}
