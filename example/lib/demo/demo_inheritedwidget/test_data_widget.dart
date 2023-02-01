import 'package:flutter/material.dart';

import 'share_data_widget.dart';

class TestDataWidget extends StatefulWidget {

  @override
  _TestDataWidgetState createState() => _TestDataWidgetState();
}

class _TestDataWidgetState extends State<TestDataWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('TestDataWidget build');
    var text = ShareDataWidget.of(context)?.data.toString();
    return Text(text ?? '');
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    /// 父或祖先Widget中的InheritedWidget发生改变(updateShouldNotify方法返回true)时，此回调会被调用
    /// 如果当前Widget中的build方法中没有依赖InheritedWidget，则此回调不会被调用
    print('TestDataWidget dependencies change');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
