import 'package:example/theme/theme.dart';
import 'package:flutter/material.dart';

import 'route_config.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterKit',
      theme: ThemeFactory.build(),
      routes: RouteConfig.routes,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    List<String> routeNames = RouteConfig.routes.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(routeNames[index]),
            child: new Text(routeNames[index], style: theme.textTheme.bodyText2),
          );
        },
        itemCount: routeNames.length,
      ),
    );
  }
}
