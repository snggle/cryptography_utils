import 'package:codec_utils/src/codecs/hex/hex_codec.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_int_type.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Tests of SolidityIntType.canonicalName getter', () {
    test('Should [return canonical name] for SolidityIntType', () {
      // Arrange
      SolidityIntType actualSolidityIntType = SolidityIntType('int');

      // Act
      String actualCanonicalName = actualSolidityIntType.canonicalName;

      // Assert
      String expectedCanonicalName = 'int256';

      expect(actualCanonicalName, expectedCanonicalName);
    });
  });

  group('Tests of SolidityIntType.decode()', () {
    test('Should [return String] decoded from given bytes', () {
      // Arrange
      SolidityIntType actualSolidityIntType = SolidityIntType('int');
      List<int> actualBytes = HexCodec.decode(
        '0x'
        '00000000000000000000000000000000000000000000000000000000000004d2',
      );

      // Act
      String actualInt = actualSolidityIntType.decode(actualBytes, 0) as String;

      // Assert
      String expectedInt = '1234';

      expect(actualInt, expectedInt);
    });
  });

  group('Tests of SolidityIntType.fixedSize getter', () {
    test('Should [return fixed size] for SolidityIntType', () {
      // Arrange
      SolidityIntType actualSolidityIntType = SolidityIntType('int');

      // Act
      int actualFixedSize = actualSolidityIntType.fixedSize;

      // Assert
      int expectedFixedSize = 32;

      expect(actualFixedSize, expectedFixedSize);
    });
  });

  group('Tests of SolidityBoolType.hasDynamicSize getter', () {
    test('Should [return FALSE] for SolidityBoolType', () {
      // Arrange
      SolidityIntType actualSolidityIntType = SolidityIntType('int');

      // Act
      bool actualDynamicSizeBool = actualSolidityIntType.hasDynamicSize;

      // Assert
      expect(actualDynamicSizeBool, false);
    });
  });
}
