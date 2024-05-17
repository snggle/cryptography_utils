import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of BinaryUtils.binaryToInt()', () {
    test('Should [return int] created from given binary (0)', () {
      // Assert
      String actualBinary = '00000000';

      // Act
      int actualInt = BinaryUtils.binaryToInt(actualBinary);

      // Assert
      expect(actualInt, 0);
    });

    test('Should [return int] created from given binary (1)', () {
      // Assert
      String actualBinary = '00000001';

      // Act
      int actualInt = BinaryUtils.binaryToInt(actualBinary);

      // Assert
      expect(actualInt, 1);
    });

    test('Should [return int] created from given binary (240)', () {
      // Assert
      String actualBinary = '11110000';

      // Act
      int actualInt = BinaryUtils.binaryToInt(actualBinary);

      // Assert
      expect(actualInt, 240);
    });

    test('Should [return int] created from given binary (255)', () {
      // Assert
      String actualBinary = '11111111';

      // Act
      int actualInt = BinaryUtils.binaryToInt(actualBinary);

      // Assert
      expect(actualInt, 255);
    });
  });

  group('Tests of BinaryUtils.bytesToBinary()', () {
    test('Should [return binary] from given bytes (default padding)', () {
      // Assert
      List<int> actualBytes = <int>[0, 1, 2, 3, 4, 5, 6, 7];

      // Act
      String actualBinary = BinaryUtils.bytesToBinary(actualBytes);

      // Assert
      String expectedBinary = '0000000000000001000000100000001100000100000001010000011000000111';

      expect(actualBinary, expectedBinary);
    });

    test('Should [return binary] from given bytes (custom padding)', () {
      // Arrange
      List<int> actualBytes = <int>[0, 1, 2, 3, 4, 5, 6, 7];

      // Act
      String actualBinary = BinaryUtils.bytesToBinary(actualBytes, padding: 4);

      // Assert
      String expectedBinary = '00000001001000110100010101100111';

      expect(actualBinary, expectedBinary);
    });
  });

  group('Tests of BinaryUtils.intToBinary()', () {
    test('Should [return binary] from given int (default padding)', () {
      // Assert
      int actualInt = 15;

      // Act
      String actualBinary = BinaryUtils.intToBinary(actualInt);

      // Assert
      String expectedBinary = '00001111';

      expect(actualBinary, expectedBinary);
    });

    test('Should [return binary] from given int (custom padding)', () {
      // Assert
      int actualInt = 15;

      // Act
      String actualBinary = BinaryUtils.intToBinary(actualInt, padding: 4);

      // Assert
      String expectedBinary = '1111';

      expect(actualBinary, expectedBinary);
    });
  });

  group('Tests of BinaryUtils.splitBinary()', () {
    test('Should [return list of binaries] extracted from given binary (chunkSize=1)', () {
      // Assert
      String actualBinary = '110001011';

      // Act
      List<String> actualBinaries = BinaryUtils.splitBinary(actualBinary, 1);

      // Assert
      List<String> expectedBinaries = <String>['1', '1', '0', '0', '0', '1', '0', '1', '1'];

      expect(actualBinaries, expectedBinaries);
    });

    test('Should [return list of binaries] extracted from given binary (chunkSize=8)', () {
      // Assert
      String actualBinary = '00000001001000101100010101100111';

      // Act
      List<String> actualBinaries = BinaryUtils.splitBinary(actualBinary, 8);

      // Assert
      List<String> expectedBinaries = <String>['00000001', '00100010', '11000101', '01100111'];

      expect(actualBinaries, expectedBinaries);
    });
  });
}
