import 'dart:math';
import 'dart:typed_data';

/// [SecureRandom] generates cryptographically secure random numbers
class SecureRandom {
  static Uint8List getBytes(int length, {int byteSize = 8}) {
    Random randomNumberGenerator = Random.secure();
    Uint8List bytes = Uint8List(length);
    for (int i = 0; i < length; i++) {
      bytes[i] = randomNumberGenerator.nextInt((pow(2, byteSize) - 1).toInt());
    }
    return bytes;
  }
}
