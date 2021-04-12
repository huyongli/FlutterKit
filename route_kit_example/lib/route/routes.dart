import 'package:route_kit/route/route.dart';
import 'package:route_kit/transition/transition.dart';
import 'package:route_kit_example/page/common_page.dart';
import 'package:route_kit_example/page/deep_limit_page.dart';
import 'package:route_kit_example/page/home_page.dart';
import 'package:route_kit_example/page/push_and_remove_page.dart';
import 'package:route_kit_example/page/removable_page.dart';
import 'package:route_kit_example/page/return_page.dart';

import '../page/transition_page.dart';

class HomePageRoute extends LHPageRoute {
  @override
  RouteWidgetBuilder get builder => (context, params) => HomePage();

  @override
  String get name => '/';
}

class PageRoute1 extends LHPageRoute {
  PageRoute1({String? desc}) {
    if (desc != null) {
      params['key'] = desc;
    }
  }

  @override
  RouteWidgetBuilder get builder => (context, params) => CommonPage(title: name, params: params);

  @override
  String get name => 'PageRoute1';
}

class PageRoute2 extends LHPageRoute {
  @override
  RouteWidgetBuilder get builder => (context, params) => CommonPage(title: name, params: params);

  @override
  String get name => 'PageRoute2';
}

class PageRoute3 extends LHPageRoute {
  @override
  RouteWidgetBuilder get builder => (context, params) => CommonPage(title: name, params: params);

  @override
  String get name => 'PageRoute3';
}

class ReturnRoute extends LHPageRoute {
  ReturnRoute({bool needReturnParam = false}) {
    params['needReturnParam'] = needReturnParam;
  }

  @override
  RouteWidgetBuilder get builder => (context, params) => ReturnParamsPage(needReturnParam: params['needReturnParam']);

  @override
  String get name => 'PageRoute4';
}

class TitlePageRoute extends LHPageRoute {
  TitlePageRoute({String title = 'TitlePageRoute'}) {
    params['title'] = title;
  }

  @override
  RouteWidgetBuilder get builder => (context, params) => CommonPage(title: params['title']);

  @override
  String get name => 'TitlePageRoute';
}

class PushAndRemoveRoute extends LHPageRoute {
  @override
  RouteWidgetBuilder get builder => (context, params) => PushAndRemovePage(title: name);

  @override
  String get name => 'PushAndRemoveRoute';
}

class PushAndRemoveRoute2 extends LHRemovablePageRoute {
  PushAndRemoveRoute2({String title = 'PushAndRemoveRoute2', int index = -1}) {
    params['title'] = title;
    params['index'] = index;
  }

  @override
  RouteWidgetBuilder get builder =>
      (context, params) => PushAndRemovePage(title: params['title'], index: params['index']);

  @override
  String get name => 'PushAndRemoveRoute2';
}

class FirstRemovableRoute extends LHRemovablePageRoute {
  FirstRemovableRoute({String title = 'FirstRemovableRoute', int index = 1}) {
    params['title'] = title;
    params['index'] = index;
  }

  @override
  RouteWidgetBuilder get builder =>
          (context, params) => RemovablePage(title: params['title'], index: params['index']);

  @override
  String get name => 'FirstRemovableRoute';
}

class SecondRemovableRoute extends LHRemovablePageRoute {
  SecondRemovableRoute({String title = 'SecondRemovableRoute', int index = -1}) {
    params['title'] = title;
    params['index'] = index;
  }

  @override
  RouteWidgetBuilder get builder =>
          (context, params) => RemovablePage(title: params['title'], index: params['index']);

  @override
  String get name => 'SecondRemovableRoute';
}

class DeepLimitNoneContinuousRoute1 extends LHPageRoute {
  DeepLimitNoneContinuousRoute1({String title = 'NoneContinuousGroup1', int index = 1}) {
    params['title'] = title;
    params['index'] = index;
  }

  @override
  RouteWidgetBuilder get builder =>
          (context, params) => DeepLimitPage(title: params['title'], index: params['index']);

  @override
  String get name => 'DeepLimitNoneContinuousRoute1';

  @override
  RouteDeepLimit? get deepLimit => RouteDeepLimit(group: 'NoneContinuousGroup', limit: 3);
}

class DeepLimitNoneContinuousRoute2 extends LHPageRoute {
  DeepLimitNoneContinuousRoute2({String title = 'NoneContinuousGroup', int index = 1}) {
    params['title'] = title;
    params['index'] = index;
  }

  @override
  RouteWidgetBuilder get builder =>
          (context, params) => DeepLimitPage(title: params['title'], index: params['index']);

  @override
  String get name => 'DeepLimitNoneContinuousRoute2';

  @override
  RouteDeepLimit? get deepLimit => RouteDeepLimit(group: 'NoneContinuousGroup', limit: 3);
}

class ContinuousDeepLimitRoute extends LHPageRoute {
  ContinuousDeepLimitRoute({String title = 'ContinuousDeepLimitRoute', int index = 1}) {
    params['title'] = title;
    params['index'] = index;
  }

  @override
  RouteWidgetBuilder get builder =>
          (context, params) => DeepLimitPage(title: params['title'], index: params['index'], isContinuous: true);

  @override
  String get name => 'ContinuousDeepLimitRoute';

  @override
  RouteDeepLimit? get deepLimit => RouteDeepLimit(group: 'ContinuousGroup', limit: 3, isContinuousRouteLimit: true);
}

class UnknownRout extends LHPageRoute {
  @override
  RouteWidgetBuilder get builder => (context, params) => CommonPage(title: '未知路由');

  @override
  String get name => 'UnknownRout';
}

class LHTransitionRoute extends LHPageRoute {
  final TransitionType type;
  final bool isHome;

  LHTransitionRoute({required this.type, this.isHome = false});

  @override
  RouteWidgetBuilder get builder => (context, params) => TransitionPage(title: type.toString(), isHome: isHome);

  @override
  String get name => 'TransitionRoute';

  @override
  LHRouteTransition get transition => LHRouteTransition(transitionType: type);
}