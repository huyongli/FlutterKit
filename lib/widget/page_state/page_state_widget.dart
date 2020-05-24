import 'package:flutter/material.dart';

import 'page_state.dart';

class PageStateWidget extends StatelessWidget {

  PageStateWidget({
    Key key,
    this.pageState,
    this.loadingWidget,
    this.emptyWidget,
    this.errorWidget,
    this.networkErrorWidget,
    this.onReload
  }): super(key: key);

  final PageState pageState;
  final Function onReload;
  final Widget loadingWidget;
  final Widget emptyWidget;
  final Widget errorWidget;
  final Widget networkErrorWidget;


  @override
  Widget build(BuildContext context) {
    Widget child;
    if (pageState is LoadingState) {
      child = loadingWidget;
    } else if (pageState is EmptyState) {
      child = emptyWidget;
    } else if (pageState is NetworkErrorState) {
      child = networkErrorWidget;
    } else if (pageState is ErrorState) {
      child = errorWidget;
    } else {
      child = Container();
    }
    return GestureDetector(
      onTap: () {
        if (pageState is NetworkErrorState || pageState is ErrorState) {
          if (onReload != null) onReload();
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: child,
      ),
    );
  }
}
