import 'package:example/demo/demo_expansion_widget.dart';
import 'package:example/demo/demo_http/demo_http.dart';
import 'package:example/demo/demo_icon_text.dart';
import 'package:example/demo/demo_keyboard.dart';
import 'package:example/demo/demo_reader/demo_reader.dart';
import 'package:flutter/widgets.dart';

import 'demo/demo_animated_switcher.dart';
import 'demo/demo_constraninedbox.dart';
import 'demo/demo_custom_provider/cart_widget.dart';
import 'demo/demo_hero.dart';
import 'demo/demo_inheritedwidget/demo_inheritedwidget.dart';
import 'demo/demo_stagger_animation.dart';

class RouteNames {
  static const String readerPage = 'Reader';
  static const String constrainedBoxPage = 'ConstrainedBox';
  static const String inheritedWidgetPage = 'InheritedWidget';
  static const String customProviderPage = 'CustomProvider';
  static const String heroPage = 'Hero';
  static const String staggerAnimationPage = 'StaggerAnimation';
  static const String animatedSwitcherPage = 'AnimatedSwitcherAnimation';
  static const String expansionPage = 'ExpansionWidget';
  static const String httpPage = 'Http';
  static const String iconTextPage = 'IconText';
  static const String keyboard = 'Keyboard';
}

class RouteConfig {
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    RouteNames.readerPage: (BuildContext context) => DemoReader(),
    RouteNames.constrainedBoxPage: (BuildContext context) => DemoConstrainedBox(),
    RouteNames.inheritedWidgetPage: (BuildContext context) => DemoInheritedWidget(),
    RouteNames.customProviderPage: (BuildContext context) => CartWidget(),
    RouteNames.heroPage: (BuildContext context) => HeroAnimationRoute(),
    RouteNames.staggerAnimationPage: (BuildContext context) => StaggerAnimationPage(),
    RouteNames.animatedSwitcherPage: (BuildContext context) => DemoAnimatedSwitcher(),
    RouteNames.expansionPage: (BuildContext context) => DemoExpansionWidget(),
    RouteNames.httpPage: (BuildContext context) => DemoHttp(),
    RouteNames.iconTextPage: (BuildContext context) => DemoIconText(),
    RouteNames.keyboard: (BuildContext context) => DemoKeyBoard(),
  };
}