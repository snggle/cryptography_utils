import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/keccak/keccak.dart';
import 'package:cryptography_utils/src/hash/keccak/keccak_bit_length.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of Keccak256.process()', () {
    test('Should [return Keccak256 HASH] constructed from given data', () {
      //Arrange
      Uint8List actualDataToHash = Uint8List.fromList('123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~'.codeUnits);

      // Act
      Uint8List actualKeccakResult = Keccak(KeccakBitLength.keccak256).process(actualDataToHash);

      // Assert
      Uint8List expectedKeccakResult = base64Decode('BCh2dEOFXrYvTet6a/a3PPmwZvQ7KQb60c8ib9WqhfE=');

      expect(actualKeccakResult, expectedKeccakResult);
    });
  });
}
