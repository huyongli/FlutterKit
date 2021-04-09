import 'package:flutter/widgets.dart';

class UIUtil {
  static void showKeyboard(BuildContext context, FocusNode focusNode) {
    // final focusScope = FocusScope.of(context);
    // focusScope.requestFocus(FocusNode());
    // Future.delayed(Duration.zero, () => focusScope.requestFocus(focusNode));
    focusNode.requestFocus();
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void hideKeyboardWithoutContext() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
