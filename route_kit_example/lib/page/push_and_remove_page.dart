import 'package:flutter/material.dart';
import 'package:route_kit/navigator.dart';
import 'package:route_kit_example/route/routes.dart';

class PushAndRemovePage extends StatelessWidget {
  final String title;
  final int index;

  const PushAndRemovePage({Key? key, required this.title, this.index = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
            if (index == 3) {
              LHNavigator.pushAndRemoveUtil(
                context,
                PushAndRemoveRoute2(title: '页面${index + 1}', index: index + 1),
                (route) => route.routeDefinition is PushAndRemoveRoute,
              );
            } else if (index == 4) {
              LHNavigator.pop(context);
            } else {
              LHNavigator.push(context, PushAndRemoveRoute2(title: '页面${index + 1}', index: index + 1));
            }
          },
          child: Text(index == 4 ? '返回看看，前面的3个页面都被清除了' : '跳转下一个: ${index + 1}'),
        ),
      ),
    );
  }
}
