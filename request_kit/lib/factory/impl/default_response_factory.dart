import '../../api/request.dart';
import '../response_factory.dart';

class DefaultResponseFactory extends ResponseFactory {
  @override
  Future<dynamic> handleResponse(Request request, dynamic response) async {
    return response;
  }
}
