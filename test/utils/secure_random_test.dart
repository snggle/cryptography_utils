import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SecureRandom.getBytes()', () {
    test('Should [return random bytes] with [length == 1] and values within the [range <0, 1>]', () {
      // Act
      Uint8List actualBytes = SecureRandom.getBytes(length: 1, max: 1);

      // Assert
      bool actualValuesInRangeBool = actualBytes.every((int byte) => byte >= 0 && byte <= 1);

      expect(actualBytes.length, 1);
      expect(actualValuesInRangeBool, true);
    });

    test('Should [return random bytes] with [length == 1] and values within the [range <0, 2>]', () {
      // Act
      Uint8List actualBytes = SecureRandom.getBytes(length: 1, max: 2);

      // Assert
      bool actualValuesInRangeBool = actualBytes.every((int byte) => byte >= 0 && byte <= 2);

      expect(actualBytes.length, 1);
      expect(actualValuesInRangeBool, true);
    });

    test('Should [return random bytes] with [length == 1] and values within the [range <0, 255>]', () {
      // Act
      Uint8List actualBytes = SecureRandom.getBytes(length: 1, max: 255);

      // Assert
      bool actualValuesInRangeBool = actualBytes.every((int byte) => byte >= 0 && byte <= 255);

      expect(actualBytes.length, 1);
      expect(actualValuesInRangeBool, true);
    });

    // **************************************************************************************************

    test('Should [return random bytes] with [length == 2] and values within the [range <0, 1>]', () {
      // Act
      Uint8List actualBytes = SecureRandom.getBytes(length: 2, max: 1);

      // Assert
      bool actualValuesInRangeBool = actualBytes.every((int byte) => byte >= 0 && byte <= 1);

      expect(actualBytes.length, 2);
      expect(actualValuesInRangeBool, true);
    });

    test('Should [return random bytes] with [length == 2] and values within the [range <0, 2>]', () {
      // Act
      Uint8List actualBytes = SecureRandom.getBytes(length: 2, max: 2);

      // Assert
      bool actualValuesInRangeBool = actualBytes.every((int byte) => byte >= 0 && byte <= 2);

      expect(actualBytes.length, 2);
      expect(actualValuesInRangeBool, true);
    });

    test('Should [return random bytes] with [length == 2] and values within the [range <0, 255>]', () {
      // Act
      Uint8List actualBytes = SecureRandom.getBytes(length: 2, max: 255);

      // Assert
      bool actualValuesInRangeBool = actualBytes.every((int byte) => byte >= 0 && byte <= 255);

      expect(actualBytes.length, 2);
      expect(actualValuesInRangeBool, true);
    });

    // **************************************************************************************************

    test('Should [return random bytes] with [length == 256] and values within the [range <0, 1>]', () {
      // Act
      Uint8List actualBytes = SecureRandom.getBytes(length: 256, max: 1);

      // Assert
      bool actualValuesInRangeBool = actualBytes.every((int byte) => byte >= 0 && byte <= 1);

      expect(actualBytes.length, 256);
      expect(actualValuesInRangeBool, true);
    });

    test('Should [return random bytes] with [length == 256] and values within the [range <0, 2>]', () {
      // Act
      Uint8List actualBytes = SecureRandom.getBytes(length: 256, max: 2);

      // Assert
      bool actualValuesInRangeBool = actualBytes.every((int byte) => byte >= 0 && byte <= 2);

      expect(actualBytes.length, 256);
      expect(actualValuesInRangeBool, true);
    });

    test('Should [return random bytes] with [length == 256] and values within the [range <0, 255>]', () {
      // Act
      Uint8List actualBytes = SecureRandom.getBytes(length: 256, max: 255);

      // Assert
      bool actualValuesInRangeBool = actualBytes.every((int byte) => byte >= 0 && byte <= 255);

      expect(actualBytes.length, 256);
      expect(actualValuesInRangeBool, true);
    });
  });
}
