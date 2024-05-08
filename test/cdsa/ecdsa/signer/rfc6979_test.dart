import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of RFC6979.generateNextK()', () {
    // Arrange
    BigInt actualK;
    RFC6979 actualRFC6979 = RFC6979(
      m: 'Hello Word'.codeUnits,
      n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
      d: BigInt.parse('15864759622800253937020257025334897817812874204769186060960403729801414344643'),
      hashFunction: sha256,
    );

    test('Should [return 1st k] for given message', () {
      // Act
      actualK = actualRFC6979.generateNextK();

      // Assert
      BigInt expectedK = BigInt.parse('88812974560257212982887499926255360508697235223425121547133315455333161949091');

      expect(actualK, expectedK);
    });

    test('Should [return 2nd k] for given message', () {
      // Act
      actualK = actualRFC6979.generateNextK();

      // Assert
      BigInt expectedK = BigInt.parse('39895679606177596180287448438804030706681317903018289114299200620908600491251');

      expect(actualK, expectedK);
    });

    test('Should [return 3rd k] for given message', () {
      // Act
      actualK = actualRFC6979.generateNextK();

      // Assert
      BigInt expectedK = BigInt.parse('97287072958682325125178613215978617558522978457213714644802934270632351217368');

      expect(actualK, expectedK);
    });
  });
}
