import 'package:flutter/foundation.dart';

import 'api_executor.dart';
import '../config/request_config.dart';
import '../factory/request_client.dart';
import '../factory/request_header_factory.dart';
import '../factory/request_param_factory.dart';
import '../factory/response_factory.dart';
import '../factory/url_factory.dart';
import '../common/request_method.dart';

class Api {
  final DomainFactory domain;
  final PathFactory path;
  final RequestParamFactory params;
  final RequestHeaderFactory headers;
  final ResponseFactory response;
  final RequestClient client;
  final int connectTimeout; // milliseconds
  final int readTimeout; // milliseconds
  RequestMethod _method;

  RequestMethod get method => _method;

  ApiExecutor _apiExecutor = ApiExecutor();

  /// update by [ApiExecutor]
  String key;

  Api({
    @required this.domain,
    @required this.path,
    @required this.params,
    @required this.headers,
    @required this.response,
    @required this.client,
    int connectTimeout,
    int readTimeout,
  })  : assert(domain != null),
        assert(path != null),
        assert(params != null),
        assert(headers != null),
        assert(response != null),
        assert(client != null),
        this.connectTimeout = connectTimeout ?? RequestConfig.instance.connectTimeout,
        this.readTimeout = connectTimeout ?? RequestConfig.instance.readTimeout;

  Future<dynamic> get() async {
    _method = RequestMethod.GET;
    return await _apiExecutor.execute(this);
  }

  Future<dynamic> post() async {
    _method = RequestMethod.POST;
    return await _apiExecutor.execute(this);
  }

  Future<dynamic> delete() async {
    _method = RequestMethod.DELETE;
    return await _apiExecutor.execute(this);
  }

  Future<dynamic> patch() async {
    _method = RequestMethod.PATCH;
    return await _apiExecutor.execute(this);
  }

  Future<dynamic> put() async {
    _method = RequestMethod.PUT;
    return await _apiExecutor.execute(this);
  }

  void cancel() {
    _apiExecutor.cancel(apiKey: key ?? '');
  }
}
