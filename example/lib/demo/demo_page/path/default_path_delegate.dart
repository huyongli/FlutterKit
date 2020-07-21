import 'package:flutter/painting.dart';

import '../page_painter.dart';
import 'path_delegate.dart';

class DefaultPathDelegate extends PathDelegate {
  @override
  Path getPathA(Size size) {
    return null;
  }

  @override
  Point getDefaultFPoint(Size size) {
    return Point(x: size.width, y: size.height);
  }
}