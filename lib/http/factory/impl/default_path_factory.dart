import '../../request_method.dart';
import '../url_factory.dart';

class DefaultPathFactory extends PathFactory {
  DefaultPathFactory(String path) : super(path);

  @override
  Future<String> newPath(
      Map<String, dynamic> params, RequestMethod method) async {
    String newPath = path;
    List<String> pathKeys = [];
    params?.forEach((key, value) {
      bool hasKey = newPath.contains('{$key}');
      if (hasKey) {
        newPath = newPath.replaceAll('{$key}', value);
        pathKeys.add(key);
      }
    });
    pathKeys.forEach((key) => params.remove(key));
    return newPath;
  }
}
