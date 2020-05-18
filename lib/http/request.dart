import 'request_method.dart';

class Request {
  final String domain;
  final String path;
  final RequestMethod method;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> params;
  final int connectTimeout;// milliseconds
  final int readTimeout;// milliseconds

  String get url {
    bool domainSlash = domain.endsWith('/');
    bool pathSlash = path.startsWith('/');
    if (domainSlash && pathSlash) {
      return '$domain${path.replaceFirst('/', '')}';
    } else if (!domainSlash && !pathSlash) {
      return '$domain/$path';
    }
    return '$domain$path';
  }

  Request({
    this.domain,
    this.path,
    this.method,
    this.headers,
    this.params,
    this.connectTimeout,
    this.readTimeout
  });

  @override
  String toString() {
    return '$domain$path${method.toString()}${headers.toString()}${params.toString()}';
  }
}