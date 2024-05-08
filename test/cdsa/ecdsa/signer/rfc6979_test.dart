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
      BigInt expectedK = BigInt.parse('55363610068230945866195479904364332371309073732412980602033091501520302568611');

      expect(actualK, expectedK);
    });

    test('Should [return 2nd k] for given message', () {
      // Act
      actualK = actualRFC6979.generateNextK();

      // Assert
      BigInt expectedK = BigInt.parse('6446984329827201161639586424862907291104184339952330734639705342348070727455');

      expect(actualK, expectedK);
    });

    test('Should [return 3rd k] for given message', () {
      // Act
      actualK = actualRFC6979.generateNextK();

      // Assert
      BigInt expectedK = BigInt.parse('99171740025834307469794610228569422856896562362771710481536067169873355338700');

      expect(actualK, expectedK);
    });
  });
}
