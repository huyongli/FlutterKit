import '../common/request_method.dart';

class Request {
  final String domain;
  final String path;
  final RequestMethod method;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> params;
  final int connectTimeout; // milliseconds
  final int readTimeout; // milliseconds

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
    required this.domain,
    required this.path,
    required this.method,
    required this.headers,
    required this.params,
    required this.connectTimeout,
    required this.readTimeout,
  });

  @override
  String toString() {
    return '$domain$path${method.toString()}${headers.toString()}${params.toString()}';
  }
}
