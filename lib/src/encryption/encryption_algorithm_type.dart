enum EncryptionAlgorithmType {
  aesdhke('AES/DHKE');

  final String name;

  const EncryptionAlgorithmType(this.name);

  static EncryptionAlgorithmType fromString(String name) {
    switch (name) {
      case 'AES/DHKE':
        return EncryptionAlgorithmType.aesdhke;
      default:
        throw ArgumentError('Invalid encryption algorithm type: $name');
    }
  }
}