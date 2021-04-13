import 'package:flutter/material.dart';

enum PageStateType { empty, error, networkError, gone, loading }

class PageWidget extends StatelessWidget {
  final PageStateType stateType;
  final WidgetBuilder? emptyBuilder;
  final WidgetBuilder? errorBuilder;
  final WidgetBuilder? networkErrorBuilder;
  final WidgetBuilder? loadingBuilder;
  final Color color;
  final EdgeInsets padding;

  const PageWidget({
    Key? key,
    required this.stateType,
    this.emptyBuilder,
    this.errorBuilder,
    this.networkErrorBuilder,
    this.loadingBuilder,
    this.color = Colors.white,
    this.padding = EdgeInsets.zero,
  })  : assert((stateType == PageStateType.empty && emptyBuilder != null) || stateType != PageStateType.empty),
        assert((stateType == PageStateType.error && errorBuilder != null) || stateType != PageStateType.error),
        assert((stateType == PageStateType.networkError && networkErrorBuilder != null) ||
            stateType != PageStateType.networkError),
        assert((stateType == PageStateType.loading && loadingBuilder != null) || stateType != PageStateType.loading),
        super(key: key);

  WidgetBuilder? get _builder {
    switch (stateType) {
      case PageStateType.empty:
        return emptyBuilder;
      case PageStateType.error:
        return errorBuilder;
      case PageStateType.networkError:
        return networkErrorBuilder;
      case PageStateType.loading:
        return loadingBuilder;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (stateType == PageStateType.gone) {
      return Container();
    }
    return Container(
      width: double.infinity,
      color: color,
      padding: padding,
      alignment: Alignment.center,
      child: _builder?.call(context),
    );
  }
}
