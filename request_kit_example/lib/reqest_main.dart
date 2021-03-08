import 'package:flutter/material.dart';

import 'request/common_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainWidget(),
    );
  }
}

class MainWidget extends StatefulWidget {

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  String result = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laohu request'),
      ),
      body: Center(
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
      ),
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