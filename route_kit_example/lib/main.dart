import 'package:flutter/material.dart';
import 'package:route_kit/navigator.dart';
import 'package:route_kit_example/route/routes.dart';

void main() {
  runApp(RouteApp());
}

class RouteApp extends StatefulWidget {
  @override
  _RouteAppState createState() => _RouteAppState();
}

class _RouteAppState extends State<RouteApp> {
  @override
  void initState() {
    super.initState();
    LHNavigator.registerRoutes(
      routes: [
        PageRoute1(),
        PageRoute2(),
        PageRoute3(),
        ReturnRoute(),
        PushAndRemoveRoute(),
        PushAndRemoveRoute2(),
        DeepLimitNoneContinuousRoute1(),
        DeepLimitNoneContinuousRoute2(),
        ContinuousDeepLimitRoute(),
        FirstRemovableRoute(),
        SecondRemovableRoute(),
      ],
      homeRoute: HomePageRoute(),
      unknownRoute: UnknownRout(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: LHNavigator.routeObservers,
      home: LHNavigator.getHomePage(context),
    );
  }
}