import 'package:flutter_test/flutter_test.dart';
import 'package:laohu_kit/laohu_kit.dart';

void main() {
  test('test formatMoneyPattern', () {
    expect(TextUtil.formatMoneyPattern('123'), '￥123');
    expect(TextUtil.formatMoneyPattern('1123'), '￥1,123');
    expect(TextUtil.formatMoneyPattern('1133323'), '￥1,133,323');
  });
}