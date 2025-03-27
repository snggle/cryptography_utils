class InvalidPaddingValueException implements Exception {
  final String? message;

  InvalidPaddingValueException([this.message]);

  @override
  String toString() => message ?? runtimeType.toString();
}
