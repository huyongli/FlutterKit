import 'package:flutter/material.dart';

import '../common/common_page.dart';

class StaggerAnimationPage extends StatefulWidget {

  @override
  _StaggerAnimationPageState createState() => _StaggerAnimationPageState();
}

class _StaggerAnimationPageState extends State<StaggerAnimationPage> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 2000), vsync: this);
  }

  void _playAnimation() async {
    try {
      /// 正向执行动画
      await _controller.forward().orCancel;
      /// 反向执行动画
      await _controller.reverse().orCancel;
    } catch(e) {
      /// 动画被取消
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonPage.builder(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _playAnimation,
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                border: Border.all(color: Colors.black.withOpacity(0.5))
            ),
            child: StaggerAnimation(controller: _controller),
          ),
        ),
      ),
      title: '交织动画(Stagger Animation)'
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}


class StaggerAnimation extends StatelessWidget {

  final Animation<double> controller;
  late Animation<double> height;
  late Animation<EdgeInsets> padding;
  late Animation<Color?> color;

  StaggerAnimation({super.key, required this.controller}) {
    height = Tween<double>(begin: 0, end: 300)
        .animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0, 0.6, curve: Curves.ease)
        ));
    color = ColorTween(begin: Colors.green, end: Colors.red)
        .animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0, 0.6, curve: Curves.ease)
        ));
    padding = Tween<EdgeInsets>(begin: EdgeInsets.only(left: 0), end: EdgeInsets.only(left: 100))
        .animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.6, 1, curve: Curves.ease)
        ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50,
        height: height.value,
      ),
    );
  }
}
