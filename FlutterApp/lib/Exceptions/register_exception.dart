class RegisterException implements Exception {
  final dynamic message;

  RegisterException([this.message]);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}
