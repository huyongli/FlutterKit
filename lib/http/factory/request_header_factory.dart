abstract class RequestHeaderFactory {
  Future<Map<String, dynamic>> buildHeaders(Map<String, dynamic> requestParam);
}