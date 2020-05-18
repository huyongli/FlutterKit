import '../../request.dart';
import '../../request_exception.dart';
import '../response_factory.dart';

extension ResponseMap on Map<String, dynamic> {

  List<dynamic> getListResponse() {
    if (!this.containsKey('list') || this['list'] is! List) {
      throw ClientException('当前返回的Response不是List');
    }
    return this['list'];
  }

  String getStringResponse() {
    if (!this.containsKey('data') || this['data'] is! String) {
      throw ClientException('当前返回的Response不是String');
    }
    return this['data'];
  }
}

class DefaultResponseFactory extends ResponseFactory {
  @override
  Future<Map<String, dynamic>> handleResponse(
      Request request, dynamic response) async {
    try {
      Map raw;
      if (response is List) {
        raw = {'list': response};
      } else if (response is String) {
        raw = {'data': response};
      } else {
        raw = response;
      }
      Map<String, dynamic> finalResponse = Map<String, dynamic>.from(raw);
      return finalResponse;
    } catch (e) {
      throw ClientException('解析错误: ${e.toString()}');
    }
  }
}
