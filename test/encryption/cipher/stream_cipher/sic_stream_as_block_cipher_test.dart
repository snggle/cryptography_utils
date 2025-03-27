import 'dart:typed_data';

import 'package:cryptography_utils/src/encryption/aes/aes_engine.dart';
import 'package:cryptography_utils/src/encryption/aes/aes_key.dart';
import 'package:cryptography_utils/src/encryption/cipher/a_key_parameter.dart';
import 'package:cryptography_utils/src/encryption/cipher/param_with_iv.dart';
import 'package:cryptography_utils/src/encryption/cipher/stream_cipher/sic_stream_cipher_as_block_cipher.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  late SicStreamAsBlockCipher sicStreamCipher;

  const int actualBlockSize = 16;
  final AesKey actualKeyUint8List = AesKey(Uint8List.fromList(List<int>.filled(actualBlockSize, 0x00)));
  final Uint8List actualIvUint8List = Uint8List.fromList(List<int>.generate(actualBlockSize, (int i) => i));

  setUp(() {
    sicStreamCipher = SicStreamAsBlockCipher(AesEngine());

    ParamWithIV<AKeyParameter> parameterWithIV = ParamWithIV<AKeyParameter>(
      actualKeyUint8List,
      actualIvUint8List,
    );

    sicStreamCipher.init(parameterWithIV);
  });
  group('Tests of SicStreamCipher.process()', () {
    test('Should [return encrypted InputUint8List] constructed from given data', () {
      // Arrange
      Uint8List actualInputUint8List =
          Uint8List.fromList(<int>[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);

      // Act
      Uint8List actualEncryptedUint8List = sicStreamCipher.process(actualInputUint8List);
      sicStreamCipher.init(ParamWithIV<AKeyParameter>(actualKeyUint8List, actualIvUint8List));
      Uint8List actualDecryptedUint8List = sicStreamCipher.process(actualEncryptedUint8List);

      // Assert
      Uint8List expectedInputUint8List = Uint8List.fromList(List<int>.filled(32, 0x01));
      expect(actualDecryptedUint8List, expectedInputUint8List);
    });

    test('Should [return encrypts data] constructed from given data', () {
      // Arrange
      Uint8List inputUint8List = Uint8List.fromList(<int>[171, 171, 171, 171, 171, 171, 171, 171, 171, 171, 171, 171, 171, 171, 171, 171]);

      // Act
      Uint8List actualOutputUint8List = sicStreamCipher.process(inputUint8List);
      Uint8List expectedOutputUint8List = Uint8List.fromList(<int>[209, 97, 164, 114, 23, 125, 71, 215, 52, 60, 237, 205, 189, 77, 9, 41]);

      // Assert
      expect(actualOutputUint8List, expectedOutputUint8List); // stream cipher modifies data
    });

    test('Should [return decrypted data] constructed from encrypted data', () {
      // Arrange
      Uint8List encryptedUint8List = Uint8List.fromList(<int>[122, 203, 13, 218, 184, 211, 234, 123, 151, 158, 76, 109, 26, 235, 172, 141]);
      ParamWithIV<AKeyParameter> params = ParamWithIV<AKeyParameter>(actualKeyUint8List, actualIvUint8List);
      // Act

      sicStreamCipher.init(params);

      Uint8List actualDecryptedUint8List = sicStreamCipher.process(encryptedUint8List);

      // Assert
      Uint8List expectedDecryptedUint8List = Uint8List.fromList(<int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
      expect(actualDecryptedUint8List, expectedDecryptedUint8List);
    });
  });
}
