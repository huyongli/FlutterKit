import 'package:flutter/material.dart';

import 'change_notifier_provider.dart';

class Consumer<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T? value) builder;

  Consumer({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context)
    );
  }
}
