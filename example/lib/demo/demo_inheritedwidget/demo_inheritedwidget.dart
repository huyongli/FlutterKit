import 'package:flutter/material.dart';

import 'share_data_widget.dart';
import 'test_data_widget.dart';

class DemoInheritedWidget extends StatefulWidget {

  @override
  _DemoInheritedWidgetState createState() => _DemoInheritedWidgetState();
}

class _DemoInheritedWidgetState extends State<DemoInheritedWidget> {
  int count = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InheritedWidget Demo'),
      ),
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: ShareDataWidget(
          data: count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: TestDataWidget(),
              ),
              RaisedButton(
                child: Text('Increment'),
                onPressed: () => setState(() => ++count),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
