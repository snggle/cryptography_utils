import 'dart:typed_data';

import 'package:cryptography_utils/src/encryption/aes/aes_engine.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_key.dart';
import 'package:cryptography_utils/src/encryption/cipher/a_key_parameter.dart';
import 'package:cryptography_utils/src/encryption/cipher/cipher_mode.dart';
import 'package:cryptography_utils/src/encryption/cipher/i_cipher_param.dart';
import 'package:cryptography_utils/src/encryption/cipher/padded_block_cipher/padded_block_cipher.dart';
import 'package:cryptography_utils/src/encryption/cipher/padded_block_cipher/padded_block_cipher_parameters.dart';
import 'package:cryptography_utils/src/encryption/cipher/param_with_iv.dart';
import 'package:cryptography_utils/src/encryption/cipher/stream_cipher/sic_stream_cipher_as_block_cipher.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  // Arrange
  final AesKey key = AesKey(Uint8List.fromList(<int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]));
  final Uint8List iv = Uint8List.fromList(<int>[15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]);

  final PaddedBlockCipher paddedBlockCipherImplementation = PaddedBlockCipher(SicStreamAsBlockCipher(AesEngine()));

  final PaddedBlockCipherParameter<ICipherParam, ICipherParam> paddedBlockCipherParameter = PaddedBlockCipherParameter<ICipherParam, ICipherParam>(
    ParamWithIV<AKeyParameter>(key, iv),
  );

  group('PaddedBlockCipherImplementation.process()', () {
    test('Should return [encrypted data] constructed from given data', () {
      // Arrange
      Uint8List plaintextUint8List = Uint8List.fromList(<int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

      // Act
      paddedBlockCipherImplementation.init(cipherMode: CipherMode.encryption, cipherParameter: paddedBlockCipherParameter);

      Uint8List actualEncryptedUint8List = paddedBlockCipherImplementation.process(plaintextUint8List);

      // Assert
      Uint8List expectedEncryptedUint8List = Uint8List.fromList(<int>[33, 171, 250, 150, 177, 74, 92, 224, 13, 21, 250, 218, 106, 168, 159, 108]);
      expect(actualEncryptedUint8List, expectedEncryptedUint8List);
    });

    test('Should return [decrypted data] constructed from encrypted data', () {
      // Arrange
      Uint8List plaintextUint8List = Uint8List.fromList(<int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

      // Act
      paddedBlockCipherImplementation.init(cipherMode: CipherMode.encryption, cipherParameter: paddedBlockCipherParameter);
      Uint8List encryptedUint8List = paddedBlockCipherImplementation.process(plaintextUint8List);

      paddedBlockCipherImplementation.init(cipherMode: CipherMode.decryption, cipherParameter: paddedBlockCipherParameter);

      Uint8List actualDecryptedUint8List = paddedBlockCipherImplementation.process(encryptedUint8List);
      Uint8List actualUint8List = actualDecryptedUint8List.sublist(0, plaintextUint8List.length);

      // Assert
      Uint8List expectedUint8List = Uint8List.fromList(<int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
      expect(actualUint8List, expectedUint8List);
    });
  });
}
