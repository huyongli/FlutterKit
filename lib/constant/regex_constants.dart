class RegexConstants {
  /// regex of digit text
  static const String REGEX_DIGIT = r"^\d{1,}$";

  /// simple regex of mobile phone, only start with 1
  static const String REGEX_MOBILE_PHONE_LOOSEST = r"^(?:(?:\+|00)86)?1\d{10}$";

  /// loose regex of mobile phone, only start with 13,14,15,16,17,18,19
  static const String REGEX_MOBILE_PHONE_LOOSE = r"^(?:(?:\+|00)86)?1[3-9]\d{9}$";

  /// strict regex of mobile phone
  static const String REGEX_MOBILE_PHONE_STRICT = r"^(?:(?:\+|00)86)?1(?:(?:3[\d])|(?:4[5-7|9])|(?:5[0-3|5-9])|(?:6[5-7])|(?:7[0-8])|(?:8[\d])|(?:9[1|8|9]))\d{8}$";

  /// Regex of id card number which length is 15.
  static const String REGEX_ID_CARD15 = r"^[1-9]\d{7}(?:0\d|10|11|12)(?:0[1-9]|[1-2][\d]|30|31)\d{3}$";

  /// Regex of id card number which length is 18.
  static const String REGEX_ID_CARD18 = r"^[1-9]\d{5}(?:18|19|20)\d{2}(?:0\d|10|11|12)(?:0[1-9]|[1-2]\d|30|31)\d{3}[\dXx]$";

  /// Regex of email
  static const String REGEX_EMAIL = r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$";

  ///Regex of blank text
  static const String REGEX_BLANK = r"\s+";

  /// Regex of chinese character
  static const String REGEX_CHINESE = r"^[\u4e00-\u9fa5]+$";
}