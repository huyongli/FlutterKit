import '../constant/regex_constants.dart';
import 'text_util.dart';

class RegexUtil {

  static bool isDigitText(String text) {
    return validate(Regexs.REGEX_DIGIT, text);
  }

  /// 是否是手机号
  static bool isMobilePhoneNo(String text, {PhoneRule rule = PhoneRule.loosest}) {
    String pattern;
    switch (rule) {
      case PhoneRule.strict:
        pattern = Regexs.REGEX_MOBILE_PHONE_STRICT;
        break;
      case PhoneRule.loose:
        pattern = Regexs.REGEX_MOBILE_PHONE_LOOSE;
        break;
      case PhoneRule.loosest:
        pattern = Regexs.REGEX_MOBILE_PHONE_LOOSEST;
        break;
    }
    return validate(pattern, text);
  }

  static bool isIDCard(String text) {
    return isIDCard18(text) || isIDCard15(text);
  }

  /// 18位身份证号
  static bool isIDCard18(String text) {
    return validate(Regexs.REGEX_ID_CARD18, text);
  }

  /// 15位身份证号
  static bool isIDCard15(String text) {
    return validate(Regexs.REGEX_ID_CARD15, text);
  }

  static bool isEmail(String text) {
    return validate(Regexs.REGEX_EMAIL, text);
  }

  static bool isBlank(String text) {
    return TextUtil.isEmpty(text) || validate(Regexs.REGEX_BLANK, text);
  }

  static bool isChineseText(String text) {
    return validate(Regexs.REGEX_CHINESE, text);
  }

  static bool validate(String regex, String text) {
    if (TextUtil.isEmpty(text)) {
      return false;
    }
    return RegExp(regex).hasMatch(text);
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