class TextUtil {
  static bool isEmpty(String text) {
    return text == null || text.isEmpty;
  }

  static bool isNotEmpty(String text) {
    return !isEmpty(text);
  }

  static bool isDigitText(String text) {
    return isNotEmpty(text) && RegExp(r"^\d{1,}$").hasMatch(text);
  }

  /// 验证是否为手机号
  static bool isPhoneNo(String text, {PhoneRule rule = PhoneRule.loosest}) {
    String pattern;
    switch (rule) {
      case PhoneRule.strict:
        pattern = r"^(?:(?:\+|00)86)?1(?:(?:3[\d])|(?:4[5-7|9])|(?:5[0-3|5-9])|(?:6[5-7])|(?:7[0-8])|(?:8[\d])|(?:9[1|8|9]))\d{8}$";
        break;
      case PhoneRule.loose:
        pattern = r"^(?:(?:\+|00)86)?1[3-9]\d{9}$";
        break;
      case PhoneRule.loosest:
        pattern = r"^(?:(?:\+|00)86)?1\d{10}$";
        break;
    }
    return isNotEmpty(text) && RegExp(pattern).hasMatch(text);
  }

  /// 验证是否为身份证号码
  /// 支持1|2代身份证号，15|18位
  static bool isIdentityNumber(String text) {
    String pattern = r"(^\d{8}(0\\d|10|11|12)([0-2]\d|30|31)\d{3}$)|(^\d{6}(18|19|20)\d{2}(0\d|10|11|12)([0-2]\d|30|31)\d{3}(\d|X|x)$)";
    return isNotEmpty(text) && RegExp(pattern).hasMatch(text);
  }
}

/// 手机号校验规则
enum PhoneRule {
  /// 根据工信部2019年公布的手机号段进行验证
  strict,
  /// 只需要13，14，15，16，17，18，19开头即可
  loose,
  /// 只需要数字1开头即可
  loosest
}