abstract class RequestParamFactory {
  Map<String, dynamic>? params;

  RequestParamFactory(this.params);

  Future<Map<String, dynamic>> buildRequestParams();
}
