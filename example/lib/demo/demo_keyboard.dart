import 'dart:ui';

import 'package:example/common/common_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laohu_kit/laohu_kit.dart';

class DemoKeyBoard extends StatefulWidget {

  @override
  _DemoKeyBoardState createState() => _DemoKeyBoardState();
}

class _DemoKeyBoardState extends State<DemoKeyBoard> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => isKeyboardShow = window.viewInsets.bottom > 0);
    });
  }

  var isKeyboardShow = false;
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return CommonPage.builder(
        title: 'Keyboard',
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(focusNode: focusNode),
              SizedBox(height: 20),
              RaisedButton(
                  child: Text('show keyboard'),
                  onPressed: () {
                    UIUtil.showKeyboard(context, focusNode);
                  }
              ),
              SizedBox(height: 20),
              RaisedButton(
                  child: Text('hide keyboard'),
                  onPressed: () {
                    UIUtil.hideKeyboard(context);
                  }
              ),
              SizedBox(height: 20),
              Text('键盘已显示： $isKeyboardShow')
            ],
          ),
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
