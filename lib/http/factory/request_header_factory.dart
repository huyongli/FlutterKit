abstract class RequestHeaderFactory {
  /// build customer header of request
  /// the requestParam is build by RequestParamFactory
  Future<Map<String, dynamic>> buildHeaders(Map<String, dynamic> requestParam);
}