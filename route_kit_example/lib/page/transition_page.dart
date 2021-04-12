import 'package:flutter/material.dart';
import 'package:route_kit/navigator.dart';
import 'package:route_kit/transition/transition.dart';

import '../route/routes.dart';

class TransitionPage extends StatelessWidget {
  final String title;
  final bool isHome;

  const TransitionPage({Key? key, required this.title, required this.isHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listView = ListView(
          children: [
            ElevatedButton(
              onPressed: () => LHNavigator.push(context, LHTransitionRoute(type: TransitionType.none)),
              child: Text('Transition none'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => LHNavigator.push(context, LHTransitionRoute(type: TransitionType.inFromLeft)),
              child: Text('Transition inFromLeft'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => LHNavigator.push(context, LHTransitionRoute(type: TransitionType.inFromRight)),
              child: Text('Transition inFromRight'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => LHNavigator.push(context, LHTransitionRoute(type: TransitionType.inFromBottom)),
              child: Text('Transition inFromBottom'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => LHNavigator.push(context, LHTransitionRoute(type: TransitionType.inFromTop)),
              child: Text('Transition inFromTop'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => LHNavigator.push(context, LHTransitionRoute(type: TransitionType.fadeIn)),
              child: Text('Transition fadeIn'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => LHNavigator.push(context, LHTransitionRoute(type: TransitionType.material)),
              child: Text('Transition material'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => LHNavigator.push(context, LHTransitionRoute(type: TransitionType.materialFullScreenDialog)),
              child: Text('Transition materialFullScreenDialog'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => LHNavigator.push(context, LHTransitionRoute(type: TransitionType.cupertino)),
              child: Text('Transition cupertino'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => LHNavigator.push(context, LHTransitionRoute(type: TransitionType.cupertinoFullScreenDialog)),
              child: Text('Transition cupertinoFullScreenDialog'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => LHNavigator.push(context, LHTransitionRoute(type: TransitionType.scale)),
              child: Text('Transition scale'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => LHNavigator.push(context, LHTransitionRoute(type: TransitionType.rotationScale)),
              child: Text('Transition rotationScale'),
            ),
          ],
        );
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 30),
        child: isHome ? listView : Text(title),
      ),
    );
  }
}
