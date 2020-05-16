import 'package:flutter/material.dart';

class DemoConstrainedBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ConstrainedBox Demo'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: double.infinity, minHeight: 50),
            child: Container(
              height: 5,
              child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red)
              ),
            ),
          ),
          SizedBox(height: 20),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 90, minHeight: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 60, minHeight: 60),
              child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red)
              ),
            ),
          ),
          SizedBox(height: 20),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60, minHeight: 60),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 90, minHeight: 20),
              child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red)
              ),
            ),
          ),
          SizedBox(height: 20),
          Divider(color: Colors.blue),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60, minHeight: 80),
            child: UnconstrainedBox( // “去除”父级限制
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 90, minHeight: 20),
                child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.red)
                ),
              ),
            ),
          ),
          Divider(color: Colors.blue),
        ],
      ),
    );
  }
}
