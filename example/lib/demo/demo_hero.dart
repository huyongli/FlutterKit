import 'package:flutter/material.dart';

import '../common/common_page.dart';

class HeroAnimationRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CommonPage.builder(
      title: 'Hero',
      child: Container(
        alignment: Alignment.center,
        child: InkWell(
          child: Hero(
            tag: 'avatar',/// 共享元素唯一标记，前后两个路由页面总的Hero的tag必须相同
            child: ClipOval(
              child: Image.network(
                  'https://gank.io/images/f9523ebe24a34edfaedf2dd0df8e2b99',
                width: 200,
              ),
            ),
          ),
          onTap: () {
            Navigator.push(context, PageRouteBuilder(
                pageBuilder: (BuildContext context, Animation<double> animation, Animation secondaryAnimation) {
                  return new FadeTransition(
                    opacity: animation,
                    child: CommonPage.builder(child: Center(
                      child: Hero(
                        tag: 'avatar',
                        child: Image.network('https://gank.io/images/f9523ebe24a34edfaedf2dd0df8e2b99'),
                      ),
                    ), title: '原图'),
                  );
                }
            ));
          },
        ),
      )
    );
  }
}

