import '../request_method.dart';

abstract class DomainFactory {
  Future<String> newDomain();
}

abstract class PathFactory {
  final String path;

  PathFactory(this.path);

  Future<String> newPath(Map<String, dynamic> params, RequestMethod method);
}