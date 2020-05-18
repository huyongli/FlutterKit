import 'api.dart';
import 'request.dart';

class ApiExecutor {
  Map<String, Api> _cacheApi = {};

  Future<dynamic> execute(Api api) async {
    String domain = await api.domain.newDomain();
    Map<String, dynamic> params = await api.params.buildRequestParams();
    String path = await api.path.newPath(params, api.method);
    Map<String, dynamic> headers = await api.headers.buildHeaders(params ?? {});

    Request request = Request(
        domain: domain,
        path: path,
        method: api.method,
        headers: headers,
        params: params,
        connectTimeout: api.connectTimeout,
        receiveTimeout: api.readTimeout);

    api.key = request.toString();
    _cacheApi[api.key] = api;

    dynamic response;
    try {
      dynamic resp = await api.client.execute(request);
      response = await api.response.handleResponse(request, resp);
    } catch (e) {
      throw e;
    } finally {
      if (_cacheApi.containsKey(api.key)) {
        _cacheApi.remove(api.key);
      }
    }
    return response;
  }

  void cancel({String apiKey}) {
    if (_cacheApi.containsKey(apiKey)) {
      _cacheApi[apiKey].client.cancel();
    }
  }
}
