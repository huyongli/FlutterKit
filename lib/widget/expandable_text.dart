import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:laohu_kit/util/text_measure_util.dart';

class ExpandableText extends StatefulWidget {
  static const double _defaultIconSize = 16;

  /// 需要展示文本内容
  final String text;

  /// 自定义"展开"文本
  final String expandText;

  /// 自定义"收起"文本
  final String collapseText;

  /// 文本内容的样式
  final TextStyle style;

  /// "展开"、"收起"的文本颜色
  final Color linkColor;

  /// 文本内容全部展示之前，最多展示的行数
  final int maxLines;

  /// 默认是否展示全部文本
  final bool expanded;

  /// 展开 图标
  final Widget expandIcon;

  /// 收起 图标
  final Widget collapseIcon;

  /// 显示图标时，图标的size
  final double iconSize;

  /// 展开收起的监听
  /// 不需要展示展开收起时，不会响应
  final Function(bool) onExpandChanged;

  const ExpandableText({
    Key key,
    this.text,
    this.expandText = '展开',
    this.collapseText = '收起',
    this.style,
    this.linkColor = Colors.black,
    this.maxLines = 5,
    this.expanded = false,
    this.expandIcon = const Icon(Icons.keyboard_arrow_down, size: _defaultIconSize, color: Colors.black),
    this.collapseIcon = const Icon(Icons.keyboard_arrow_up, size: _defaultIconSize, color: Colors.black),
    this.iconSize = _defaultIconSize,
    this.onExpandChanged,
  })  : assert(text != null && text.length != 0),
        assert(style != null),
        assert(linkColor != null),
        assert(expanded != null),
        assert((expandIcon != null && collapseIcon != null && iconSize != null) ||
            (expandIcon == null && collapseIcon == null && iconSize == null)),
        super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;
  TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _expanded = widget.expanded;
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          _expanded = !_expanded;
          widget.onExpandChanged?.call(_expanded);
        });
      };

    if (widget.onExpandChanged != null && widget.expanded == true) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.onExpandChanged.call(true);
      });
    }
  }

  @override
  void didUpdateWidget(ExpandableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text ||
        oldWidget.expandText != widget.expandText ||
        oldWidget.collapseText != widget.collapseText ||
        oldWidget.linkColor != widget.linkColor ||
        oldWidget.expanded != widget.expanded ||
        oldWidget.maxLines != widget.maxLines) {
      _expanded = widget.expanded;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      var measurer = TextMeasurer(maxLines: widget.maxLines, maxWidth: constraints.maxWidth);

      /// 测量"展开"文本的宽度
      measurer.measure(text: TextSpan(text: widget.expandText, style: widget.style));
      Size expandSize = measurer.textRect;

      /// 测量要展示文本的宽度
      measurer.measure(text: TextSpan(text: widget.text, style: widget.style));
      Size textSize = measurer.textRect;

      var pixOffset = Offset(textSize.width - expandSize.width - widget.iconSize ?? 0, textSize.height);
      int endPosition = measurer.getPositionBefore(pixOffset);

      TextSpan textSpan;
      if (measurer.didExceedMaxLines) {
        textSpan = TextSpan(children: [
          TextSpan(text: _expanded ? widget.text : widget.text.substring(0, endPosition), style: widget.style),
          TextSpan(
            text: _expanded ? widget.collapseText : widget.expandText,
            style: widget.style.copyWith(color: widget.linkColor),
            recognizer: _tapGestureRecognizer,
          ),
          if (widget.expandIcon != null)
            WidgetSpan(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => _tapGestureRecognizer.onTap.call(),
                child: _expanded ? widget.collapseIcon : widget.expandIcon,
              ),
              alignment: PlaceholderAlignment.middle,
            )
        ]);
      } else {
        textSpan = TextSpan(text: widget.text, style: widget.style);
      }
      return Text.rich(textSpan);
    });
  }
}
