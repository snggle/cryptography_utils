import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_string_type.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  // Arrange
  SolidityStringType actualSolidityStringType = SolidityStringType();

  group('Tests of SolidityStringType.canonicalName getter', () {
    test('Should [return canonical name] for SolidityStringType', () {
      // Act
      String actualCanonicalName = actualSolidityStringType.canonicalName;

      // Assert
      String expectedCanonicalName = 'string';

      expect(actualCanonicalName, expectedCanonicalName);
    });
  });

  group('Tests of SolidityStringType.decode()', () {
    test('Should [return String] decoded from given bytes (dynamic)', () {
      // Arrange
      List<int> actualBytes = HexEncoder.decode(
        '0x'
        '000000000000000000000000000000000000000000000000000000000000000c'
        '48656c6c6f20576f726c64210000000000000000000000000000000000000000',
      );

      // Act
      String actualText = actualSolidityStringType.decode(actualBytes, 0);

      // Assert
      String expectedString = 'Hello World!';

      expect(actualText, expectedString);
    });
  });

  group('Tests of SolidityStringType.fixedSize getter', () {
    test('Should [return fixed size] for SolidityStringType (dynamic)', () {
      // Act
      int actualFixedSize = actualSolidityStringType.fixedSize;

      // Assert
      int expectedFixedSize = 32;

      expect(actualFixedSize, expectedFixedSize);
    });
  });

  group('Tests of SolidityStringType.hasDynamicSize getter', () {
    test('Should [return TRUE] for SolidityStringType', () {
      // Arrange
      SolidityStringType actualSolidityStringType = SolidityStringType();

      // Act
      bool actualDynamicSizeBool = actualSolidityStringType.hasDynamicSize;

      // Assert
      expect(actualDynamicSizeBool, true);
    });
  });
}
