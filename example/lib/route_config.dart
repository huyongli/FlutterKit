import 'package:example/demo/demo_expandable_text.dart';
import 'package:example/demo/demo_expandable_widget.dart';
import 'package:example/demo/demo_http/demo_http.dart';
import 'package:example/demo/demo_icon_text.dart';
import 'package:example/demo/demo_keyboard.dart';
import 'package:example/demo/demo_reader/demo_reader.dart';
import 'package:example/demo/demo_simulation_page/demo_simulation_page.dart';
import 'package:example/demo/demo_textpainter.dart';
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
  static const String staggerAnimationPage = '交织动画';
  static const String animatedSwitcherPage = 'AnimatedSwitcherAnimation';
  static const String expansionPage = 'ExpandableWidget';
  static const String httpPage = 'Http';
  static const String iconTextPage = 'IconText';
  static const String keyboard = 'Keyboard';
  static const String textPainter = '文本测量';
  static const String expandCollapsePage = '文本展开收起';
  static const String simulationPage = '仿真翻页';
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
    RouteNames.expansionPage: (BuildContext context) => DemoExpandableWidget(),
    RouteNames.httpPage: (BuildContext context) => DemoHttp(),
    RouteNames.iconTextPage: (BuildContext context) => DemoIconText(),
    RouteNames.keyboard: (BuildContext context) => DemoKeyBoard(),
    RouteNames.textPainter: (BuildContext context) => DemoTextPainter(),
    RouteNames.simulationPage: (BuildContext context) => DemoSimulationPage(),
    RouteNames.expandCollapsePage: (BuildContext context) => DemoExpandableText(),
  };
}