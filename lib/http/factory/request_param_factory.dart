abstract class RequestParamFactory {
  Map<String, dynamic> params;

  RequestParamFactory(this.params);

  /// the build value will be put into request
  Future<Map<String, dynamic>> buildRequestParams();
}