import 'package:flutter/material.dart';

enum PageState { empty, error, networkError, gone, loading }

class StatePageWidget extends StatelessWidget {
  final PageState state;
  final WidgetBuilder? emptyBuilder;
  final WidgetBuilder? errorBuilder;
  final WidgetBuilder? networkErrorBuilder;
  final WidgetBuilder? loadingBuilder;
  final Color color;
  final EdgeInsets padding;
  final Function? onPressed;

  const StatePageWidget({
    Key? key,
    required this.state,
    this.emptyBuilder,
    this.errorBuilder,
    this.networkErrorBuilder,
    this.loadingBuilder,
    this.onPressed,
    this.color = Colors.white,
    this.padding = EdgeInsets.zero,
  })  : assert((state == PageState.empty && emptyBuilder != null) || state != PageState.empty),
        assert((state == PageState.error && errorBuilder != null) || state != PageState.error),
        assert((state == PageState.networkError && networkErrorBuilder != null) ||
            state != PageState.networkError),
        assert((state == PageState.loading && loadingBuilder != null) || state != PageState.loading),
        super(key: key);

  WidgetBuilder? get _builder {
    switch (state) {
      case PageState.empty:
        return emptyBuilder;
      case PageState.error:
        return errorBuilder;
      case PageState.networkError:
        return networkErrorBuilder;
      case PageState.loading:
        return loadingBuilder;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (state == PageState.gone) {
      return Container();
    }
    return Container(
      width: double.infinity,
      color: color,
      padding: padding,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () => onPressed?.call(),
        child: _builder?.call(context),
      ),
    );
  }
}
