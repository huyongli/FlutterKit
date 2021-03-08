import 'package:example/common/common_page.dart';
import 'package:flutter/material.dart';
import 'package:laohu_kit/widget/expandable_widget.dart';

class DemoExpandableWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return CommonPage.builder(
      title: 'Expansion Demo',
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildFixedUpExpansionWidget(context),
            SizedBox(height: 20),
            _buildFixedDownExpansionWidget(context),
            SizedBox(height: 20),
            _buildFixedLeftExpansionWidget(context),
            SizedBox(height: 20),
            _buildFixedRightExpansionWidget(context)
          ],
        ),
      )
    );
  }
  
  Widget _buildFixedUpExpansionWidget(BuildContext context) {
    return ExpandableWidget(
      fixedWidget: Container(
        alignment: Alignment.center,
        width: double.infinity,
        color: Colors.blue,
        height: 40,
        child: Text('固定上边'),
      ),
      fixedWidgetDirection: AxisDirection.up,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 40,
          color: Colors.black12,
          child: Text('上child1'),
        ),
        Divider(),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 40,
          color: Colors.black12,
          child: Text('上child2'),
        )
      ],
    );
  }

  Widget _buildFixedDownExpansionWidget(BuildContext context) {
    return ExpandableWidget(
      fixedWidget: Container(
        alignment: Alignment.center,
        width: double.infinity,
        color: Colors.green,
        height: 40,
        child: Text('固定下边'),
      ),
      fixedWidgetDirection: AxisDirection.down,
      initiallyExpanded: true,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 40,
          color: Colors.black38,
          child: Text('下child1'),
        ),
        Divider(),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 40,
          color: Colors.black38,
          child: Text('下child2'),
        )
      ],
    );
  }

  Widget _buildFixedLeftExpansionWidget(BuildContext context) {
    return ExpandableWidget(
      fixedWidget: Container(
        alignment: Alignment.center,
        color: Colors.red,
        width: 40,
        height: 200,
        child: Text('固定左边'),
      ),
      fixedWidgetDirection: AxisDirection.left,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: 40,
          height: 200,
          color: Colors.black26,
          child: Text('左child1'),
        ),
        Divider(),
        Container(
          alignment: Alignment.center,
          width: 40,
          height: 200,
          color: Colors.black26,
          child: Text('左child2'),
        )
      ],
    );
  }

  Widget _buildFixedRightExpansionWidget(BuildContext context) {
    return ExpandableWidget(
      fixedWidget: Container(
        alignment: Alignment.center,
        color: Colors.lightGreen,
        width: 40,
        height: 200,
        child: Text('固定右边'),
      ),
      fixedWidgetDirection: AxisDirection.right,
      initiallyExpanded: true,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: 40,
          height: 200,
          color: Colors.black45,
          child: Text('右child1'),
        ),
        Divider(),
        Container(
          alignment: Alignment.center,
          width: 40,
          height: 200,
          color: Colors.black45,
          child: Text('右child2'),
        )
      ],
    );
  }
}
