class TextUtil {
  static bool isEmpty(String text) {
    return text == null || text.isEmpty;
  }

  static bool isNotEmpty(String text) {
    return !isEmpty(text);
  }

  static bool isTrimEmpty(String text) {
    return text == null || text.trim().isEmpty;
  }

  static int length(String text) {
    return text == null ? 0 : text.length;
  }

  static String reverse(String text) {
    if (isEmpty(text)) return '';
    StringBuffer sb = StringBuffer();
    for (int i = text.length - 1; i >= 0; i--) {
      sb.writeCharCode(text.codeUnitAt(i));
    }
    return sb.toString();
  }

  /// 每隔 x 位加 pattern, 从末尾开始
  static String formatDigitPatternEnd(String text,
      {int digit = 4, String pattern = ' '}) {
    String temp = reverse(text);
    temp = formatDigitPattern(temp, digit: digit, pattern: pattern);
    temp = reverse(temp);
    return temp;
  }

  /// 每隔 x 位加 pattern, 从头开始
  static String formatDigitPattern(String text,
      {int digit = 4, String pattern = ' '}) {
    text = text?.replaceAllMapped(RegExp("(.{$digit})"), (Match match) {
      return "${match.group(0)}$pattern";
    });
    if (text != null && text.endsWith(pattern)) {
      text = text.substring(0, text.length - 1);
    }
    return text;
  }

  /// 对金额进行格式化：￥12,333,333
  static String formatMoneyPattern(String text, {String pattern = '￥', bool isSeparate = true, String separate = ','}) {
    if (isTrimEmpty(text)) {
      return '';
    }
    String tmp = isSeparate ? formatDigitPatternEnd(text, digit: 3, pattern: separate) : text;
    return '$pattern$tmp';
  }
}