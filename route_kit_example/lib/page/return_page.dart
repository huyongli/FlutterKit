import 'dart:math';

import 'package:flutter/material.dart';
import 'package:route_kit/core/navigator.dart';
import 'package:route_kit_example/route/routes.dart';

class ReturnParamsPage extends StatefulWidget {
  final bool needReturnParam;

  const ReturnParamsPage({Key? key, this.needReturnParam = false}) : super(key: key);

  @override
  _ReturnParamsPageState createState() => _ReturnParamsPageState();
}

class _ReturnParamsPageState extends State<ReturnParamsPage> {
  String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ReturnParamsPage')),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                if (widget.needReturnParam) {
                  LHNavigator.pop(context, params: {'params': '我是返回值${Random().nextInt(100)}'});
                } else {
                  LHNavigator.push(context, ReturnRoute(needReturnParam: true)).then((params) {
                    setState(() {
                      this.value = params['params'];
                    });
                  });
                }
              },
              child: Text(widget.needReturnParam ? '带参数返回' : '跳转获取参数'),
            ),
            if (this.value != null && this.value!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(value!),
              )
          ],
        ),
      ),
    );
  }
}
