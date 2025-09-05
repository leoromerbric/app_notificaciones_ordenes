sealed class AppException implements Exception {
  const AppException(this.message);
  
  final String message;
}

class NetworkException extends AppException {
  const NetworkException(super.message);
}

class ServerException extends AppException {
  const ServerException(super.message);
}

class ValidationException extends AppException {
  const ValidationException(super.message);
}

class UnknownException extends AppException {
  const UnknownException(super.message);
}

class BarcodeException extends AppException {
  const BarcodeException(super.message);
}