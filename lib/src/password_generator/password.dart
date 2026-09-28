class Password {
  final String password;
  final int randomCharacterCount;
  final int checksumCharacterCount;

  const Password({
    required this.password,
    required this.randomCharacterCount,
    required this.checksumCharacterCount,
  });
}