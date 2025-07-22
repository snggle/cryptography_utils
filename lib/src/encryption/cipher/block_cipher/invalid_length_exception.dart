class InvalidLengthException implements Exception {
  final String? message;

  InvalidLengthException([this.message]);

  @override
  String toString() => message ?? runtimeType.toString();
}
