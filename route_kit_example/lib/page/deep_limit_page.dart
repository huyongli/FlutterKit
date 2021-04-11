import 'package:flutter/material.dart';
import 'package:route_kit/core/navigator.dart';
import 'package:route_kit_example/route/routes.dart';

int continuousIndex = 1;
int noneContinuousIndex = 0;
class DeepLimitPage extends StatelessWidget {
  final String title;
  final int index;
  final bool isContinuous;

  DeepLimitPage({Key? key, required this.title, this.index = 0, this.isContinuous = false}) : super(key: key) {
    if (index == 1) {
      continuousIndex = 1;
      noneContinuousIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('isContinuous: $isContinuous'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (index == 10) {
                  LHNavigator.pop(context);
                  return;
                }
                if (index % 3 == 0) {
                  LHNavigator.push(
                      context, ContinuousDeepLimitRoute(title: '$nextTitle: ${++continuousIndex}', index: index + 1));
                } else if (index % 3 == 1) {
                  LHNavigator.push(
                      context, DeepLimitNoneContinuousRoute2(title: '$nextTitle: ${++noneContinuousIndex}', index: index + 1));
                } else {
                  LHNavigator.push(
                      context, DeepLimitNoneContinuousRoute1(title: '$nextTitle: ${++noneContinuousIndex}', index: index + 1));
                }
              },
              child: Text(index == 10 ? '返回看看' : '跳转下一个'),
            ),
          ],
        ),
      ),
    );
  }

  String get nextTitle => index % 3 == 0 ? 'ContinuousGroup' : 'NoneContinuousGroup';
}
