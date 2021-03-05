import 'package:flutter/material.dart';

class ExpansionWidget extends StatefulWidget {
  const ExpansionWidget({
    Key key,
    @required this.fixedWidget,
    this.children = const <Widget>[],
    this.fixedWidgetDirection = AxisDirection.up,
    this.childrenCrossAxisAlignment = CrossAxisAlignment.center,
    this.childrenMainAxisAlignment = MainAxisAlignment.start,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
  })  : assert(fixedWidget != null),
        assert(fixedWidgetDirection != null),
        assert(childrenCrossAxisAlignment != null),
        assert(childrenMainAxisAlignment != null),
        assert(children != null),
        assert(initiallyExpanded != null),
        super(key: key);

  /// fix widget direction by the children
  final AxisDirection fixedWidgetDirection;

  /// fix widget
  final Widget fixedWidget;

  /// The widgets that are displayed when the tile expands.
  final List<Widget> children;

  /// The children widgets cross axis alignment, same as column or row
  final CrossAxisAlignment childrenCrossAxisAlignment;

  /// The children widgets main axis alignment, same as column or row
  final MainAxisAlignment childrenMainAxisAlignment;

  /// Called when the tile expands or collapses.
  final ValueChanged<bool> onExpansionChanged;

  final bool initiallyExpanded;

  @override
  _ExpansionWidgetState createState() => _ExpansionWidgetState();
}

class _ExpansionWidgetState extends State<ExpansionWidget> with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);

  AnimationController _controller;
  Animation<double> _sizeFactor;

  bool get isVerticalDirection =>
      widget.fixedWidgetDirection == AxisDirection.up || widget.fixedWidgetDirection == AxisDirection.down;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _sizeFactor = _controller.drive(_easeInTween);

    _isExpanded = PageStorage.of(context)?.readState(context) as bool ?? widget.initiallyExpanded;

    if (_isExpanded) _controller.value = 1.0;
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
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null) widget.onExpansionChanged(_isExpanded);
  }

  Widget _buildFixedWidget(BuildContext context, Widget child) {
    List<Widget> children;
    switch (widget.fixedWidgetDirection) {
      case AxisDirection.up:
      case AxisDirection.left:
        children = _buildFixedWidgetChildren(child);
        break;
      case AxisDirection.down:
      case AxisDirection.right:
        children = _buildFixedWidgetChildren(child).reversed.toList();
        break;
    }
    return Container(
      child: isVerticalDirection
          ? Column(mainAxisSize: MainAxisSize.min, children: children)
          : Row(mainAxisSize: MainAxisSize.min, children: children),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    Widget expansionChild = isVerticalDirection
        ? Column(
            children: widget.children,
            crossAxisAlignment: widget.childrenCrossAxisAlignment,
            mainAxisAlignment: widget.childrenMainAxisAlignment,
          )
        : Row(
            children: widget.children,
            crossAxisAlignment: widget.childrenCrossAxisAlignment,
            mainAxisAlignment: widget.childrenMainAxisAlignment,
          );
    return AnimatedBuilder(
        animation: _controller.view, builder: _buildFixedWidget, child: closed ? null : expansionChild);
  }

  List<Widget> _buildFixedWidgetChildren(Widget child) {
    return [
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _handleTap,
        child: widget.fixedWidget,
      ),
      ClipRect(
        child: Align(
          heightFactor: isVerticalDirection ? _sizeFactor.value : null,
          widthFactor: isVerticalDirection ? null : _sizeFactor.value,
          child: child,
        ),
      )
    ];
  }
}
