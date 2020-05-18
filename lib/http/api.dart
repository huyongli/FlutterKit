import 'package:flutter/cupertino.dart';

import 'api_executor.dart';
import 'factory/request_client.dart';
import 'factory/request_header_factory.dart';
import 'factory/request_param_factory.dart';
import 'factory/response_factory.dart';
import 'factory/url_factory.dart';
import 'request_method.dart';

const int _timeOut = 30000;
class Api {
  final DomainFactory domain;
  final PathFactory path;
  final RequestParamFactory params;
  final RequestHeaderFactory headers;
  final ResponseFactory response;
  final RequestClient client;
  final int connectTimeout;// milliseconds
  final int readTimeout;// milliseconds

  ApiExecutor _apiExecutor = ApiExecutor();
  
  RequestMethod method;
  
  String key;

  Api({
    @required this.domain,
    @required this.path,
    @required this.params,
    @required this.headers,
    @required this.response,
    @required this.client,
    @required this.method,
    this.connectTimeout = _timeOut,
    this.readTimeout = _timeOut
  }): assert(domain != null),
      assert(path != null),
      assert(params != null),
      assert(headers != null),
      assert(response != null),
      assert(client != null),
      assert(method != null),
      assert(connectTimeout > 0),
      assert(readTimeout > 0);
  
  Future<Map<String, dynamic>> execute() async {
    return await _apiExecutor.execute(this);
  }

  void cancel() {
    _apiExecutor.cancel(apiKey: key ?? '');
  }
}