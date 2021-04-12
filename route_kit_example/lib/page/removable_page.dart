import 'package:flutter/material.dart';
import 'package:route_kit/navigator.dart';
import 'package:route_kit_example/route/routes.dart';

class RemovablePage extends StatelessWidget {
  final String title;
  final int index;

  RemovablePage({Key? key, required this.title, this.index = 0}) : super(key: key) {
    print('RemovablePage: index: $index');
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
            if (index == 4)
              ElevatedButton(
                onPressed: ()  {
                  LHNavigator.clearRemovable(context);
                },
                child: Text('清除栈中所有LHRemovablePageRoute路由'),
              ),
            if (index == 4)
              ElevatedButton(
                onPressed: () {
                  LHNavigator.popRemovable<SecondRemovableRoute>(context);
                },
                child: Text('清除栈中所有SecondRemovableRoute路由'),
              ),
            if (index != 4)
              ElevatedButton(
                onPressed: () {
                  print('RemovablePage: index~/2: ${index~/2} index%2: ${index % 2}\n');
                  if (index % 2 == 0) {
                    LHNavigator.push(context, FirstRemovableRoute(title: 'FirstRemovableRoute ${(index+1)~/2 + (index+1)%2}', index: index + 1));
                  } else {
                    LHNavigator.push(context, SecondRemovableRoute(title: 'SecondRemovableRoute ${index~/2 + index%2}', index: index + 1));
                  }
                },
                child: Text('下一个: ${index + 1}'),
              ),
          ],
        ),
      ),
    );
  }
}
