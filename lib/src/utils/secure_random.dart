import 'dart:math';
import 'dart:typed_data';

/// [SecureRandom] generates cryptographically secure random numbers.
class SecureRandom {
  static Uint8List getBytes({required int length, required int max}) {
    Random randomNumberGenerator = Random.secure();
    Uint8List bytes = Uint8List(length);
    for (int i = 0; i < length; i++) {
      // IMPORTANT NOTE: nextInt() returns a value from 0 to X - 1
      // Be careful to avoid non-uniform distribution of random numbers
      bytes[i] = randomNumberGenerator.nextInt(max + 1).toInt();
    }
    return bytes;
  }
}
