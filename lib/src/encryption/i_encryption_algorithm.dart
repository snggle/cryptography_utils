import 'package:cryptography_utils/cryptography_utils.dart';

abstract interface class IEncryptionAlgorithm {
  Ciphertext encrypt(String password, String plaintext);

  String decrypt(String password, Ciphertext ciphertext);

  bool isPasswordValid(String password, Ciphertext ciphertext);
}