import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  Uint8List actualDataToHash = Uint8List.fromList('123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~'.codeUnits);

  group('Tests of Ripemd160.process()', () {
    test('Should [return Ripemd160 HASH] constructed from given data', () {
      // Act
      Uint8List actualRipemd160Result = Ripemd160().process(actualDataToHash);

      // Assert
      Uint8List expectedRipemd160Result = base64Decode('iJS43Wf/c7ZqtImU2HYR0laE3q4=');

      expect(actualRipemd160Result, expectedRipemd160Result);
    });
  });
}
