import 'package:example/common/common_page.dart';
import 'package:flutter/material.dart';

import 'request/common_api.dart';

class DemoHttp extends StatefulWidget {

  @override
  _DemoHttpState createState() => _DemoHttpState();
}

class _DemoHttpState extends State<DemoHttp> {
  String result = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonPage.builder(
      title: 'Http Demo',
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(result),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () => requestMap(),
              child: new Text('请求Map'),
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () => requestList(),
              child: new Text('请求List'),
            )
          ],
        ),
      )
    );
  }

  void requestList() async {
    List<dynamic> response = await CommonApi(path: 'list').get();
    setState(() {
      result = response.toString();
    });
  }

  void requestMap() async {
    Map<String, dynamic> response =  await CommonApi(path: 'map').get();
    setState(() {
      result = response.toString();
    });
  }
}
