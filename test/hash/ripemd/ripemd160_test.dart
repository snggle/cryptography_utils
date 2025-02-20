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

  group('Tests of Ripemd160.resetState()', () {
    test('Should [return stateList] when resetState() is called', () {
      // Act
      Ripemd160 ripemd160 = Ripemd160()..resetState();
      List<int> actualStateList = ripemd160.stateList;

      // Assert
      List<int> expectedStateList = <int>[0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476, 0xc3d2e1f0];

      expect(actualStateList, expectedStateList);
    });
  });

  group('Tests of Ripemd160.processBlock()', () {
    test('Should [return stateList] when processBlock() is called', () {
      // Act
      Ripemd160 ripemd160 = Ripemd160();
      ripemd160.bufferList.setAll(0, List<int>.generate(16, (int i) => i));
      ripemd160.processBlock();
      List<int> actualStateList = ripemd160.stateList;

      // Assert
      List<int> expectedStateList = <int>[0xADDECDB1, 0x583CD1D3, 0x14BA1875, 0x9759865C, 0x392A0539];
      expect(actualStateList, expectedStateList);
    });
  });
}
