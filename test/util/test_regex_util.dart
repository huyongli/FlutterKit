import 'package:flutter_test/flutter_test.dart';
import 'package:laohu_kit/util/regex_util.dart';

void main() {

  test('test isDigit', () {
    expect(RegexUtil.isDigitText(''), false);
    expect(RegexUtil.isDigitText('a123'), false);
    expect(RegexUtil.isDigitText('1a23'), false);
    expect(RegexUtil.isDigitText('123a'), false);
    expect(RegexUtil.isDigitText('-123'), false);
    expect(RegexUtil.isDigitText('1.23'), false);
    expect(RegexUtil.isDigitText('123'), true);
  });

  test('test isMobilePhoneNo', (){
    expect(RegexUtil.isMobilePhoneNo('1322323986'), false);
    expect(RegexUtil.isMobilePhoneNo('13223239867'), true);
    expect(RegexUtil.isMobilePhoneNo('+8613223239867'), true);

    expect(RegexUtil.isMobilePhoneNo('+8612223239867', rule: PhoneRule.loose), false);
    expect(RegexUtil.isMobilePhoneNo('12223239867', rule: PhoneRule.loose), false);
  });

  test('test isChineseText', () {
    expect(RegexUtil.isChineseText(null), false);
    expect(RegexUtil.isChineseText('abc'), false);
    expect(RegexUtil.isChineseText('  '), false);
    expect(RegexUtil.isChineseText('11 '), false);
    expect(RegexUtil.isChineseText('****'), false);
    expect(RegexUtil.isChineseText('我们aaa'), false);
    expect(RegexUtil.isChineseText('我们'), true);
  });

  test('test isBlank', () {
    expect(RegexUtil.isBlank(null), true);
    expect(RegexUtil.isBlank('  '), true);
    expect(RegexUtil.isBlank('    '), true);
    expect(RegexUtil.isBlank('\n'), true);
  });

  test('test isEmail', () {
    expect(RegexUtil.isEmail(null), false);
    expect(RegexUtil.isEmail('  '), false);
    expect(RegexUtil.isEmail('123'), false);
    expect(RegexUtil.isEmail('123@'), false);
    expect(RegexUtil.isEmail('123@abc'), false);
    expect(RegexUtil.isEmail('123@abc.com'), true);
  });
}