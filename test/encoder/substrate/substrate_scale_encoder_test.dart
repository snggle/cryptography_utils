import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/encoder/substrate/substrate_scale_encoder.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SubstrateScaleEncoder.encodeString()', () {
    test('Should [return bytes] representing String encoded with SCALE', () {
      // Arrange
      String actualDecodedString = 'Hello, World!';

      // Act
      Uint8List actualEncodedBytes = SubstrateScaleEncoder.encodeString(actualDecodedString);

      // Assert
      Uint8List expectedEncodedBytes = base64Decode('NEhlbGxvLCBXb3JsZCE=');

      expect(actualEncodedBytes, expectedEncodedBytes);
    });
  });

  group('Tests of SubstrateScaleEncoder.encodeBytes()', () {
    test('Should [return bytes] representing bytes encoded with SCALE', () {
      // Arrange
      Uint8List actualBytes = base64Decode('NEhlbGxvLCBXb3JsZCE=');

      // Act
      Uint8List actualEncodedBytes = SubstrateScaleEncoder.encodeBytes(actualBytes);

      // Assert
      Uint8List expectedEncodedBytes = base64Decode('ODRIZWxsbywgV29ybGQh');

      expect(actualEncodedBytes, expectedEncodedBytes);
    });
  });

  group('Tests of SubstrateScaleEncoder.encodeCUint()', () {
    test('Should [return bytes] representing CUInt encoded with SCALE', () {
      // Arrange
      int actualCUint = 123456789;

      // Act
      Uint8List actualEncodedBytes = SubstrateScaleEncoder.encodeCUint(actualCUint);

      // Assert
      Uint8List expectedEncodedBytes = base64Decode('VjRvHQ==');

      expect(actualEncodedBytes, expectedEncodedBytes);
    });
  });

  group('Tests of SubstrateScaleEncoder.encodeUInt()', () {
    test('Should [return bytes] representing UInt encoded with SCALE', () {
      // Arrange
      BigInt actualUInt = BigInt.parse('123456789123456789123456789');

      // Act
      Uint8List actualEncodedBytes = SubstrateScaleEncoder.encodeUInt(actualUInt);

      // Assert
      Uint8List expectedEncodedBytes = base64Decode('FV8EfJ+x4/L9Hg==');

      expect(actualEncodedBytes, expectedEncodedBytes);
    });
  });

  group('Tests of SubstrateScaleEncoder.encodeUIntWithBytesLength()', () {
    test('Should [return bytes] representing UInt encoded with SCALE and fixed length', () {
      // Arrange
      BigInt actualUInt = BigInt.parse('123456789123456789123456789');
      int actualBytesLength = 16;

      // Act
      Uint8List actualEncodedBytes = SubstrateScaleEncoder.encodeUIntWithBytesLength(actualUInt, bytesLength: actualBytesLength);

      // Assert
      Uint8List expectedEncodedBytes = base64Decode('FV8EfJ+x4/L9HmYAAAAAAA==');

      expect(actualEncodedBytes, expectedEncodedBytes);
    });
  });
}
