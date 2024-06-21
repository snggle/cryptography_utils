import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_bytes_type.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Tests of SolidityBytesType.canonicalName getter', () {
    test('Should [return canonical name] for SolidityBytesType if [size SPECIFIED]', () {
      // Arrange
      SolidityBytesType actualSolidityBytesType = SolidityBytesType('bytes32');

      // Act
      String actualCanonicalName = actualSolidityBytesType.canonicalName;

      // Assert
      String expectedCanonicalName = 'bytes32';

      expect(actualCanonicalName, expectedCanonicalName);
    });

    test('Should [return canonical name] for SolidityBytesType if [size NOT SPECIFIED]', () {
      // Arrange
      SolidityBytesType actualSolidityBytesType = SolidityBytesType('bytes');

      // Act
      String actualCanonicalName = actualSolidityBytesType.canonicalName;

      // Assert
      String expectedCanonicalName = 'bytes';

      expect(actualCanonicalName, expectedCanonicalName);
    });
  });

  group('Tests of SolidityBytesType.decode()', () {
    test('Should [return String] decoded from given bytes if [size SPECIFIED] (bytes1)', () {
      // Arrange
      SolidityBytesType actualSolidityBytesType = SolidityBytesType('bytes1');
      List<int> actualBytes = HexEncoder.decode('0x1200000000000000000000000000000000000000000000000000000000000000');

      // Act
      List<int> actualOutputBytes = actualSolidityBytesType.decode(actualBytes, 0) as List<int>;

      // Assert
      List<int> expectedOutputBytes = HexEncoder.decode('0x12');

      expect(actualOutputBytes, expectedOutputBytes);
    });

    test('Should [return String] decoded from given bytes if [size SPECIFIED] (bytes8)', () {
      // Arrange
      SolidityBytesType actualSolidityBytesType = SolidityBytesType('bytes8');
      List<int> actualBytes = HexEncoder.decode('0x1234567812345678000000000000000000000000000000000000000000000000');

      // Act
      List<int> actualOutputBytes = actualSolidityBytesType.decode(actualBytes, 0) as List<int>;

      // Assert
      List<int> expectedOutputBytes = HexEncoder.decode('0x1234567812345678');

      expect(actualOutputBytes, expectedOutputBytes);
    });

    test('Should [return String] decoded from given bytes if [size SPECIFIED] (bytes16)', () {
      // Arrange
      SolidityBytesType actualSolidityBytesType = SolidityBytesType('bytes16');
      List<int> actualBytes = HexEncoder.decode('0x1234567812345678123456781234567800000000000000000000000000000000');

      // Act
      List<int> actualOutputBytes = actualSolidityBytesType.decode(actualBytes, 0) as List<int>;

      // Assert
      List<int> expectedOutputBytes = HexEncoder.decode('0x12345678123456781234567812345678');

      expect(actualOutputBytes, expectedOutputBytes);
    });

    test('Should [return String] decoded from given bytes if [size SPECIFIED] (bytes32)', () {
      // Arrange
      SolidityBytesType actualSolidityBytesType = SolidityBytesType('bytes32');
      List<int> actualBytes = HexEncoder.decode('0x1234567812345678123456781234567812345678123456781234567812345678');

      // Act
      List<int> actualOutputBytes = actualSolidityBytesType.decode(actualBytes, 0) as List<int>;

      // Assert
      List<int> expectedOutputBytes = HexEncoder.decode('0x1234567812345678123456781234567812345678123456781234567812345678');

      expect(actualOutputBytes, expectedOutputBytes);
    });

    test('Should [return String] decoded from given bytes if [size NOT SPECIFIED] (dynamic)', () {
      // Arrange
      SolidityBytesType actualSolidityBytesType = SolidityBytesType('bytes');
      List<int> actualBytes = HexEncoder.decode(
        '0x'
        '0000000000000000000000000000000000000000000000000000000000000009'
        '0102030405060708090000000000000000000000000000000000000000000000',
      );

      // Act
      List<int> actualOutputBytes = actualSolidityBytesType.decode(actualBytes, 0) as List<int>;

      // Assert
      List<int> expectedOutputBytes = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9];

      expect(actualOutputBytes, expectedOutputBytes);
    });
  });

  group('Tests of SolidityBytesType.fixedSize getter', () {
    test('Should [return fixed size] for SolidityBytesType if [size SPECIFIED]', () {
      // Arrange
      SolidityBytesType actualSolidityBytesType = SolidityBytesType('bytes8');

      // Act
      int actualFixedSize = actualSolidityBytesType.fixedSize;

      // Assert
      int expectedFixedSize = 32;

      expect(actualFixedSize, expectedFixedSize);
    });

    test('Should [return fixed size] for SolidityBytesType if [size NOT SPECIFIED]', () {
      // Arrange
      SolidityBytesType actualSolidityBytesType = SolidityBytesType('bytes');

      // Act
      int actualFixedSize = actualSolidityBytesType.fixedSize;

      // Assert
      int expectedFixedSize = 32;

      expect(actualFixedSize, expectedFixedSize);
    });
  });

  group('Tests of SolidityBytesType.hasDynamicSize getter', () {
    test('Should [return TRUE] for SolidityBytesType if [size NOT SPECIFIED]', () {
      // Arrange
      SolidityBytesType actualSolidityBytesType = SolidityBytesType('bytes');

      // Act
      bool actualDynamicSizeBool = actualSolidityBytesType.hasDynamicSize;

      // Assert
      expect(actualDynamicSizeBool, true);
    });

    test('Should [return FALSE] for SolidityBytesType if [size SPECIFIED]', () {
      // Arrange
      SolidityBytesType actualSolidityBytesType = SolidityBytesType('bytes32');

      // Act
      bool actualDynamicSizeBool = actualSolidityBytesType.hasDynamicSize;

      // Assert
      expect(actualDynamicSizeBool, false);
    });
  });
}
