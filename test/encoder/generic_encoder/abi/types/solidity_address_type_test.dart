import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_address_type.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Tests of SolidityAddressType.canonicalName getter', () {
    test('Should [return canonical name] for SolidityAddressType', () {
      // Arrange
      SolidityAddressType actualSolidityAddressType = SolidityAddressType();

      // Act
      String actualCanonicalName = actualSolidityAddressType.canonicalName;

      // Assert
      String expectedCanonicalName = 'address';

      expect(actualCanonicalName, expectedCanonicalName);
    });
  });

  group('Tests of SolidityAddressType.decode()', () {
    test('Should [return String] decoded from given bytes', () {
      // Arrange
      SolidityAddressType actualSolidityAddressType = SolidityAddressType();
      List<int> actualBytes = HexEncoder.decode('0x00000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c');

      // Act
      String actualText = actualSolidityAddressType.decode(actualBytes, 0);

      // Assert
      String expectedText = '0x53bf0a18754873a8102625d8225af6a15a43423c';

      expect(actualText, expectedText);
    });
  });

  group('Tests of SolidityAddressType.fixedSize getter', () {
    test('Should [return fixed size] for SolidityAddressType', () {
      // Arrange
      SolidityAddressType actualSolidityAddressType = SolidityAddressType();

      // Act
      int actualFixedSize = actualSolidityAddressType.fixedSize;

      // Assert
      int expectedFixedSize = 32;

      expect(actualFixedSize, expectedFixedSize);
    });
  });

  group('Tests of SolidityAddressType.hasDynamicSize getter', () {
    test('Should [return FALSE] for SolidityAddressType', () {
      // Arrange
      SolidityAddressType actualSolidityAddressType = SolidityAddressType();

      // Act
      bool actualDynamicSizeBool = actualSolidityAddressType.hasDynamicSize;

      // Assert
      expect(actualDynamicSizeBool, false);
    });
  });
}
