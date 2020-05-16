import 'package:flutter/material.dart';

class ExpansionWidget extends StatefulWidget {

  const ExpansionWidget({
    Key key,
    @required this.fixWidget,
    this.children = const <Widget>[],
    this.fixWidgetDirection = VerticalDirection.up,
    this.childrenCrossAxisAlignment = CrossAxisAlignment.center,
    this.onExpansionChanged
  }) : assert(fixWidget != null), super(key: key);

  /// fix widget direction by the children
  final VerticalDirection fixWidgetDirection;

  /// fix widget
  final Widget fixWidget;

  /// The widgets that are displayed when the tile expands.
  final List<Widget> children;

  /// The children widgets cross axis alignment, same as column or row
  final CrossAxisAlignment childrenCrossAxisAlignment;

  /// Called when the tile expands or collapses.
  final ValueChanged<bool> onExpansionChanged;

  @override
  _ExpansionWidgetState createState() =>
      _ExpansionWidgetState();
}

class _ExpansionWidgetState
    extends State<ExpansionWidget>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);

  AnimationController _controller;
  Animation<double> _heightFactor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _heightFactor = _controller.drive(_easeInTween);

    _isExpanded = PageStorage.of(context)?.readState(context) ?? false;

    if (_isExpanded)
      _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted)
            return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged(_isExpanded);
  }

  Widget _buildFixedWidget(BuildContext context, Widget child) {
    List<Widget> children;
    if (widget.fixWidgetDirection == VerticalDirection.up) {
      children = [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _handleTap,
          child: widget.fixWidget,
        ),
        ClipRect(
          child: Align(
            heightFactor: _heightFactor.value,
            child: child,
          ),
        )
      ];
    } else {
      children = [
        ClipRect(
          child: Align(
            heightFactor: _heightFactor.value,
            child: child,
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _handleTap,
          child: widget.fixWidget,
        )
      ];
    }
    return Container(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildFixedWidget,
      child: closed ? null : Column(
          children: widget.children,
          crossAxisAlignment: widget.childrenCrossAxisAlignment
      ),
    );
  }
}