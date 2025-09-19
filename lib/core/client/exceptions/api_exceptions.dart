sealed class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}

class AuthorizationException extends ApiException {
  AuthorizationException(super.message);
}

class AuthenticationException extends ApiException {
  AuthenticationException(super.message);
}

class ServerException extends ApiException {
  ServerException(super.message);
}
