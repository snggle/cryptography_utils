import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_bytes_type.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  // Arrange
  SolidityBytesType actualSolidityBytesType = SolidityBytesType();

  group('Tests of SolidityBytesType.canonicalName getter', () {
    test('Should [return canonical name] for SolidityBytesType', () {
      // Act
      String actualCanonicalName = actualSolidityBytesType.canonicalName;

      // Assert
      String expectedCanonicalName = 'bytes';

      expect(actualCanonicalName, expectedCanonicalName);
    });
  });

  group('Tests of SolidityBytesType.decode()', () {
    test('Should [return String] decoded from given bytes (dynamic)', () {
      // Arrange
      List<int> actualBytes = HexEncoder.decode(
          '0x00000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000');

      // Act
      List<int> actualOutputBytes = actualSolidityBytesType.decode(actualBytes, 0) as List<int>;

      // Assert
      List<int> expectedOutputBytes = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9];

      expect(actualOutputBytes, expectedOutputBytes);
    });

    test('Should [return String] decoded from given bytes (bytes1)', () {
      // Arrange
      SolidityBytesType actualSolidityBytesType = SolidityBytesType('bytes1');
      List<int> actualBytes = HexEncoder.decode('0x1200000000000000000000000000000000000000000000000000000000000000');

      // Act
      List<int> actualOutputBytes = actualSolidityBytesType.decode(actualBytes, 0) as List<int>;

      // Assert
      List<int> expectedOutputBytes = HexEncoder.decode('0x12');

      expect(actualOutputBytes, expectedOutputBytes);
    });

    test('Should [return String] decoded from given bytes (bytes8)', () {
      // Arrange
      SolidityBytesType actualSolidityBytesType = SolidityBytesType('bytes8');
      List<int> actualBytes = HexEncoder.decode('0x1234567812345678000000000000000000000000000000000000000000000000');

      // Act
      List<int> actualOutputBytes = actualSolidityBytesType.decode(actualBytes, 0) as List<int>;

      // Assert
      List<int> expectedOutputBytes = HexEncoder.decode('0x1234567812345678');

      expect(actualOutputBytes, expectedOutputBytes);
    });

    test('Should [return String] decoded from given bytes (bytes16)', () {
      // Arrange
      SolidityBytesType actualSolidityBytesType = SolidityBytesType('bytes16');
      List<int> actualBytes = HexEncoder.decode('0x1234567812345678123456781234567800000000000000000000000000000000');

      // Act
      List<int> actualOutputBytes = actualSolidityBytesType.decode(actualBytes, 0) as List<int>;

      // Assert
      List<int> expectedOutputBytes = HexEncoder.decode('0x12345678123456781234567812345678');

      expect(actualOutputBytes, expectedOutputBytes);
    });

    test('Should [return String] decoded from given bytes (bytes32)', () {
      // Arrange
      SolidityBytesType actualSolidityBytesType = SolidityBytesType('bytes32');
      List<int> actualBytes = HexEncoder.decode('0x1234567812345678123456781234567812345678123456781234567812345678');

      // Act
      List<int> actualOutputBytes = actualSolidityBytesType.decode(actualBytes, 0) as List<int>;

      // Assert
      List<int> expectedOutputBytes = HexEncoder.decode('0x1234567812345678123456781234567812345678123456781234567812345678');

      expect(actualOutputBytes, expectedOutputBytes);
    });
  });

  group('Tests of SolidityBytesType.fixedSize getter', () {
    test('Should [return fixed size] for SolidityBytesType (dynamic)', () {
      // Act
      int actualFixedSize = actualSolidityBytesType.fixedSize;

      // Assert
      int expectedFixedSize = 64;

      expect(actualFixedSize, expectedFixedSize);
    });
  });
}
