import 'package:flutter/material.dart';

class CommonPage {
  static Widget builder({String title, @required Widget child}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: child,
    );
  }
}