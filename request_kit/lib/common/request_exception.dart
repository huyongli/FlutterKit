class RequestException extends Error {
  final int httpCode;
  final String? message;

  RequestException({this.message, this.httpCode = -1});

  @override
  String toString() {
    return "{httpCode: $httpCode, message: '$message'}";
  }
}

class ClientException extends Error {
  final String? message;

  ClientException(this.message);

  @override
  String toString() {
    return '{message: $message}';
  }
}

class CancelException extends Error {
  @override
  String toString() {
    return 'The request canceled by client';
  }
}
