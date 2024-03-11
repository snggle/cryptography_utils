import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of KeccakF1600.process()', () {
    test('Should [return KeccakF1600 HASH] constructed from given data', () {
      // Arrange
      KeccakF1600 actualKeccakF1600 = KeccakF1600();
      List<BigInt> actualDataToHash = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.codeUnits.map(BigInt.from).toList();

      // Act
      List<BigInt> actualHash = actualDataToHash;
      actualKeccakF1600.process(actualHash);

      // Assert
      List<BigInt> expectedHash = <BigInt>[
        BigInt.parse('3543928542710604088'),
        BigInt.parse('18273176825072034724'),
        BigInt.parse('5512250004327690009'),
        BigInt.parse('952626393825121485'),
        BigInt.parse('3070943805635175131'),
        BigInt.parse('15113071305294044384'),
        BigInt.parse('13762548345604079376'),
        BigInt.parse('17155776870585546051'),
        BigInt.parse('3457557930109454379'),
        BigInt.parse('1262388651455290301'),
        BigInt.parse('14669947564513119632'),
        BigInt.parse('8422151546412180680'),
        BigInt.parse('12814046553042315100'),
        BigInt.parse('13257331380363220412'),
        BigInt.parse('7215703723011768443'),
        BigInt.parse('17118568965001945392'),
        BigInt.parse('17996701397840709940'),
        BigInt.parse('6872335572193472072'),
        BigInt.parse('12265711902188810769'),
        BigInt.parse('9755096519007714756'),
        BigInt.parse('11960167101300227032'),
        BigInt.parse('905852227418705447'),
        BigInt.parse('10558783253322251863'),
        BigInt.parse('3976249652442533868'),
        BigInt.parse('10266244761655308108'),
        BigInt.parse('90'),
      ];

      expect(actualHash, expectedHash);
    });
  });
}
