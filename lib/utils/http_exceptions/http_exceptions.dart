class AppExceptions implements Exception {
  String? prefix;
  String? message;

  AppExceptions({this.message, this.prefix});
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(message: "Error During Communication");
}

class UnauthorizedAccessException extends AppExceptions {
  UnauthorizedAccessException([String? message])
      : super(message: "Unauthorized Access");
}
