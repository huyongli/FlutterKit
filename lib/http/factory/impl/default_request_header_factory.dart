import '../request_header_factory.dart';

class DefaultRequestHeaderFactory extends RequestHeaderFactory {
  @override
  Future<Map<String, dynamic>> buildHeaders(
      Map<String, dynamic> requestParam) async {
    return {};
  }
}
