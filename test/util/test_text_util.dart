import 'package:flutter_test/flutter_test.dart';
import 'package:laohu_kit/util/text_util.dart';

void main() {

  test('test isDigit', () {
    expect(TextUtil.isDigitText(''), false);
    expect(TextUtil.isDigitText('a123'), false);
    expect(TextUtil.isDigitText('1a23'), false);
    expect(TextUtil.isDigitText('123a'), false);
    expect(TextUtil.isDigitText('-123'), false);
    expect(TextUtil.isDigitText('1.23'), false);
    expect(TextUtil.isDigitText('123'), true);
  });

  test('test isPhoneNo', (){
    expect(TextUtil.isPhoneNo('1322323986'), false);
    expect(TextUtil.isPhoneNo('13223239867'), true);
    expect(TextUtil.isPhoneNo('+8613223239867'), true);

    expect(TextUtil.isPhoneNo('+8612223239867', rule: PhoneRule.loose), false);
    expect(TextUtil.isPhoneNo('12223239867', rule: PhoneRule.loose), false);
  });
}