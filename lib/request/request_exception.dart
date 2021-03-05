class RequestExceptionCodes {
  static const String unknownCode = "-1000";
  static const int unknownHttpCode = -1;
}

class RequestException extends Error {
  final int httpCode;
  final String code;
  final String message;

  RequestException({this.code, this.message, this.httpCode});

  RequestException.newDefault()
      : code = RequestExceptionCodes.unknownCode,
        message = '未知错误',
        httpCode = RequestExceptionCodes.unknownHttpCode;

  @override
  String toString() {
    return "{httpCode: $httpCode, code: '$code', message: '$message'}";
  }
}

class ClientException extends Error {
  final String message;

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
