import 'package:flutter/material.dart';
import 'package:route_kit/navigator.dart';
import 'package:route_kit_example/common/home_item.dart';
import 'package:route_kit_example/route/routes.dart';
import 'package:route_kit/transition/transition.dart';
import 'package:route_kit_example/route/routes.dart';

class HomePage extends StatelessWidget {
  final List<HomeItem> items = [
    HomeItem(
      title: 'Push by LHRRoute',
      onTapped: (BuildContext context) => LHNavigator.push(context, PageRoute1(desc: 'Push by LHRRoute')),
    ),
    HomeItem(
      title: 'Push by name',
      onTapped: (BuildContext context) => LHNavigator.pushName(context, 'PageRoute2'),
    ),
    HomeItem(
      title: 'Push by name with params',
      onTapped: (BuildContext context) => LHNavigator.pushName(
        context,
        'PageRoute2',
        params: {'key': 'Push by name with params'},
      ),
    ),
    HomeItem(
      title: 'Push by url',
      onTapped: (BuildContext context) => LHNavigator.pushUrl(context, 'PageRoute3'),
    ),
    HomeItem(
      title: 'Push by url with params',
      onTapped: (BuildContext context) => LHNavigator.pushUrl(
        context,
        'PageRoute3',
        params: {'key': 'Push by url with params'},
      ),
    ),
    HomeItem(
      title: 'Push by url with query values',
      onTapped: (BuildContext context) => LHNavigator.pushUrl(context, 'PageRoute3?key=Url query params'),
    ),
    HomeItem(
      title: 'Push by url with query values and params',
      onTapped: (BuildContext context) => LHNavigator.pushUrl(
        context,
        'PageRoute3?urlParams=Push by url with query values',
        params: {'params': 'Push by url with query values and params'},
      ),
    ),
    HomeItem(
      title: 'Unknown route',
      onTapped: (BuildContext context) => LHNavigator.pushName(context, 'PageRoute'),
    ),
    HomeItem(
      title: 'Push and get params',
      onTapped: (BuildContext context) => LHNavigator.push(context, ReturnRoute()),
    ),
    HomeItem(
      title: 'PushAndRemoveUtil',
      onTapped: (BuildContext context) => LHNavigator.push(context, PushAndRemoveRoute()),
    ),
    HomeItem(
      title: 'Limit route deep',
      onTapped: (BuildContext context) => LHNavigator.push(context, ContinuousDeepLimitRoute(title: 'ContinuousGroup1')),
    ),
    HomeItem(
      title: 'Pop removable route',
      onTapped: (BuildContext context) => LHNavigator.push(context, FirstRemovableRoute(title: 'FirstRemovableRoute 1')),
    ),
    HomeItem(
      title: 'Transition route',
      onTapped: (BuildContext context) => LHNavigator.push(context, LHTransitionRoute(type: TransitionType.native, isHome: true)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HomePage')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => items[index].onTapped.call(context),
            child: Container(
              alignment: Alignment.center,
              child: Text(items[index].title),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(border: Border.all(color: Colors.black12, width: 0.5)),
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
