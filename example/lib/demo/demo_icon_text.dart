import 'package:example/common/common_page.dart';
import 'package:flutter/material.dart';
import 'package:laohu_kit/laohu_kit.dart';

class DemoIconText extends StatefulWidget {

  @override
  _DemoIconTextState createState() => _DemoIconTextState();
}

class _DemoIconTextState extends State<DemoIconText> {
  Color _color = Colors.black12;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonPage.builder(
        title: 'IconText Demo',
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.black12,
                child: IconText(
                    icon: Icon(Icons.school),
                    text: Text('学校')
                ),
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.black12,
                child: IconText(
                  icon: Icon(Icons.school),
                  padding: EdgeInsets.all(10),
                  text: Text('学校'),
                  direction: AxisDirection.right,
                ),
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.black12,
                child: IconText(
                  icon: Icon(Icons.school),
                  text: Text('学校'),
                  space: 10,
                  direction: AxisDirection.down,
                ),
              ),
              SizedBox(height: 20),
              Container(
                color: _color,
                child: IconText(
                  icon: Icon(Icons.search),
                  text: Text('点击'),
                  direction: AxisDirection.left,
                  onPressed: () {
                    setState(() {
                      if (_color == Colors.black12) {
                        _color = Colors.blueGrey;
                      } else {
                        _color = Colors.black12;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
