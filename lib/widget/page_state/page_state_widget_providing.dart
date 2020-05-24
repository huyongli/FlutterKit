import 'package:flutter/material.dart';

import '../../constant/duration_constants.dart';
import 'page_state_widget_factory.dart';
import 'page_state.dart';

mixin PageStateWidgetProviding {

  Widget buildPageStateStreamWidget({
    @required Stream<PageState> stream,
    @required Widget Function(SuccessState) widgetBuilder,
    PageStateWidgetFactory pageStateWidgetFactory,
    bool needAnimation = true,
  }) {
    var factory = pageStateWidgetFactory ?? PageStateWidgetFactory.buildDefault();
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, snap) {
        PageState state = snap.data;
        Widget otherWidget = Container();
        Widget successWidget = Container();
        if (state is SuccessState) {
          successWidget = widgetBuilder(state);
        } else {
          otherWidget = buildWithoutSuccessStateWidget(state: state, pageStateWidgetFactory: factory);
        }
        if (needAnimation) {
          return AnimatedCrossFade(
            firstChild: otherWidget,
            secondChild: successWidget,
            crossFadeState: state is SuccessState ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: DurationConstants.normalAnimation
          );
        } else {
          return state is SuccessState ? successWidget : otherWidget;
        }
      }
    );
  }

  Widget buildWithoutSuccessStateWidget({
    @required PageState state,
    PageStateWidgetFactory pageStateWidgetFactory,
  }) {
    var factory = pageStateWidgetFactory ?? PageStateWidgetFactory.buildDefault();
    Widget widget;
    if (state is LoadingState) {
      widget = factory.loadingWidget(state);
    } else if (state is NetworkErrorState) {
      widget = factory.networkErrorWidget(state);
    } else if (state is ErrorState) {
      widget = factory.errorWidget(state);
    } else {
      widget = factory.otherWidget();
    }
    return widget;
  }

  Widget buildWithOnlySuccessStateStreamWidget({
    @required Stream<PageState> stream,
    @required Widget Function(SuccessState) widgetBuilder,
    bool needAnimation = true,
  }) {
    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, snap) {
          PageState state = snap.data;
          Widget otherWidget = Container();
          Widget successWidget = Container();
          if (state is SuccessState) {
            successWidget = widgetBuilder(state);
          }
          if (needAnimation) {
            return AnimatedCrossFade(
                firstChild: otherWidget,
                secondChild: successWidget,
                crossFadeState: state is SuccessState ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: DurationConstants.normalAnimation
            );
          } else {
            return state is SuccessState ? successWidget : otherWidget;
          }
        }
    );
  }
}