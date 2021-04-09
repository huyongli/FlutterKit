import 'package:dio/dio.dart';

// milliseconds
const int _timeOut = 30000;

class RequestConfig {
  RequestConfig._internal();

  static final RequestConfig instance = RequestConfig._internal();

  int _connectTimeout = _timeOut;

  int get connectTimeout => _connectTimeout;

  set connectTimeout(int connectTimeout) {
    assert(connectTimeout != null && connectTimeout > 0);
    this._connectTimeout = connectTimeout;
  }

  int _readTimeout = _timeOut;

  set readTimeout(int readTimeout) {
    assert(readTimeout != null && readTimeout > 0);
    this._readTimeout = readTimeout;
  }

  int get readTimeout => _readTimeout;

  String _domain;

  set domain(String domain) {
    assert(domain != null && domain.isNotEmpty);
    this._domain = domain;
  }

  String get domain {
    assert(_domain != null && _domain.isNotEmpty);
    return _domain;
  }

  List<InterceptorsWrapper> dioInterceptors = [];
}
