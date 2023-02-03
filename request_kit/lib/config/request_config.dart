
/// milliseconds
const int _timeOut = 30000;

class RequestConfig {
  RequestConfig._internal();

  static final RequestConfig instance = RequestConfig._internal();

  int _connectTimeout = _timeOut;

  int get connectTimeout => _connectTimeout;

  set connectTimeout(int connectTimeout) {
    assert(connectTimeout > 0);
    this._connectTimeout = connectTimeout;
  }

  int _readTimeout = _timeOut;

  set readTimeout(int readTimeout) {
    assert(readTimeout > 0);
    this._readTimeout = readTimeout;
  }

  int get readTimeout => _readTimeout;

  String _domain = '';

  set domain(String domain) {
    assert(domain.isNotEmpty);
    this._domain = domain;
  }

  String get domain {
    assert(_domain.isNotEmpty);
    return _domain;
  }
}
