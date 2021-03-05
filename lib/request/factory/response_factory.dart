import '../request.dart';

abstract class ResponseFactory {
  Future<dynamic> handleResponse(Request request, dynamic response);
}
