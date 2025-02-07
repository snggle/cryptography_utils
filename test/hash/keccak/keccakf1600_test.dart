import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/keccak/keccakf1600.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Test for KeccakF1600.applyPermutation()', () {
    test('Should [apply Keccak permutation] to the input state', () {
      // Arrange
      Uint8List actualOutput = base64Decode(
          'AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4vMDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5fYGFiY2Rl'
          'ZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6PkJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/wMHCw8TFxsc=');

      // Act
      KeccakF1600().applyPermutation(actualOutput);

      // Assert
      Uint8List expectedOutput = base64Decode(
          '+nzV2vWRKBIhKXbcp+X4uF63dQKMD6yPNUUxdJYD7kcslozLbajUF7A8RLUqp38OPigxa9G2r+wJUbwINJIDzDsC5R2U2mL4CJzE8m6dtpUGF86et6wjVRreePwkbgAksto'
          'ZsAY+Cym00S/rLkG441S2xyxBqq0x5LdES6m65SGdA1yVjoHceUNdMVG9xBzkwkD95PygPnzqYXg2DTXfDSrzLPOjC8qS3cx3xQJniaPeqbza5cLHb1lBD/ZWhKEPFq'
          '4P49SBCAc=');

      expect(actualOutput, expectedOutput);
    });
  });
}
