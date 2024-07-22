import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_bool_type.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Tests of SolidityBoolType.canonicalName getter', () {
    test('Should [return canonical name] for SolidityBoolType', () {
      // Arrange
      SolidityBoolType actualSolidityBoolType = SolidityBoolType();

      // Act
      String actualCanonicalName = actualSolidityBoolType.canonicalName;

      // Assert
      String expectedCanonicalName = 'bool';

      expect(actualCanonicalName, expectedCanonicalName);
    });
  });

  group('Tests of SolidityBoolType.decode()', () {
    test('Should [return FALSE] decoded from given bytes', () {
      // Arrange
      SolidityBoolType actualSolidityBoolType = SolidityBoolType();
      List<int> actualBytes = HexEncoder.decode('0x0000000000000000000000000000000000000000000000000000000000000000');

      // Act
      bool actualBool = actualSolidityBoolType.decode(actualBytes, 0);

      // Assert
      bool expectedBool = false;

      expect(actualBool, expectedBool);
    });

    test('Should [return TRUE] decoded from given bytes', () {
      // Arrange
      SolidityBoolType actualSolidityBoolType = SolidityBoolType();
      List<int> actualBytes = HexEncoder.decode('0x0000000000000000000000000000000000000000000000000000000000000001');

      // Act
      bool actualBool = actualSolidityBoolType.decode(actualBytes, 0);

      // Assert
      bool expectedBool = true;

      expect(actualBool, expectedBool);
    });
  });

  group('Tests of SolidityBoolType.fixedSize getter', () {
    test('Should [return fixed size] for SolidityBoolType', () {
      // Arrange
      SolidityBoolType actualSolidityBoolType = SolidityBoolType();

      // Act
      int actualFixedSize = actualSolidityBoolType.fixedSize;

      // Assert
      int expectedFixedSize = 32;

      expect(actualFixedSize, expectedFixedSize);
    });
  });

  group('Tests of SolidityBoolType.hasDynamicSize getter', () {
    test('Should [return FALSE] for SolidityBoolType', () {
      // Arrange
      SolidityBoolType actualSolidityBoolType = SolidityBoolType();

      // Act
      bool actualDynamicSizeBool = actualSolidityBoolType.hasDynamicSize;

      // Assert
      expect(actualDynamicSizeBool, false);
    });
  });
}
