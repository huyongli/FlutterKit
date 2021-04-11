import 'package:flutter/material.dart';

class CommonPage extends StatelessWidget {
  final String title;
  final Map<String, dynamic>? params;

  const CommonPage({Key? key, required this.title, this.params}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('我是页面： $title'),
            if (params != null && params!.isNotEmpty) Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text('参数： ${params?.values.join(', ')}'),
            ),
          ],
        ),
      ),
    );
  }
}
