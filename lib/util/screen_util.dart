
import 'package:flutter/widgets.dart';

class ScreenUtil {
  
  static double getSafeTopHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getSafeBottomHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}