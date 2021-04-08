import 'package:flutter/material.dart';

import 'route_config.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterKit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: RouteConfig.routes,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: DefaultTextStyle(
        style: TextStyle(color: Colors.black, inherit: false, fontSize: 16),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: ListView(
            children: RouteConfig.routes.keys
                .map((routeName) => RaisedButton(
                      onPressed: () => Navigator.of(context).pushNamed(routeName),
                      child: new Text(routeName, style: theme.textTheme.button),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
