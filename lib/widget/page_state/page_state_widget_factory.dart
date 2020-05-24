import 'package:flutter/material.dart';
import 'package:laohu_kit/widget/page_state/page_state_widget.dart';

import 'page_state.dart';

class PageStateWidgetFactory {
  Widget Function(LoadingState) loadingBuilder;
  Widget Function(EmptyState) emptyBuilder;
  Widget Function(ErrorState) errorBuilder;
  Widget Function(NetworkErrorState) networkErrorBuilder;

  PageStateWidgetFactory({this.loadingBuilder, this.emptyBuilder, this.errorBuilder, this.networkErrorBuilder});

  PageStateWidgetFactory.buildDefault({
    Widget loadingWidget,
    Widget emptyWidget,
    Widget Function(String) loadingErrorBuilder,
    Widget Function(String) networkErrorBuilder,
    Function onReload
  }) {
    loadingBuilder = (state) {
      return loadingWidget ?? PageStateWidget(
        pageState: state,
        loadingWidget: CircularProgressIndicator(),
      );
    };
    emptyBuilder = (state) {
      return emptyWidget ?? PageStateWidget(
        pageState: state,
        loadingWidget: Text('Empty'),
      );
    };
    errorBuilder = (state) {
      if (loadingErrorBuilder != null) {
        return loadingErrorBuilder(state.message);
      }
      return PageStateWidget(
        pageState: state,
        loadingWidget: Text('Request Error'),
      );
    };
    this.networkErrorBuilder = (state) {
      if (networkErrorBuilder != null) {
        return networkErrorBuilder(state.message);
      }
      return PageStateWidget(
        pageState: state,
        loadingWidget: Text('Network Error'),
      );
    };
  }

  Widget loadingWidget(LoadingState state) => loadingBuilder(state);

  Widget emptyWidget(EmptyState state) => emptyBuilder(state);

  Widget errorWidget(ErrorState state) => errorBuilder(state);

  Widget networkErrorWidget(NetworkErrorState state) => networkErrorBuilder(state);

  Widget otherWidget() => Container();
}