import 'package:cryptography_utils/src/utils/ethereum_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of EthereumUtils.convertWeiToEth()', () {
    test('Should [convert 0 wei] to 0 ETH', () {
      // Act
      Decimal actualETHAmount = EthereumUtils.convertWeiToEth(BigInt.zero);

      // Assert
      Decimal expectedETHAmount = Decimal.zero;

      expect(actualETHAmount, expectedETHAmount);
    });

    test('Should [convert 1 wei] to the correct ETH amount', () {
      // Act
      Decimal actualETHAmount = EthereumUtils.convertWeiToEth(BigInt.one);

      // Assert
      Decimal expectedETHAmount = Decimal.parse('0.000000000000000001');

      expect(actualETHAmount, expectedETHAmount);
    });

    test('Should [convert arbitrary wei amount] to the correct ETH amount', () {
      // Act
      Decimal actualETHAmount = EthereumUtils.convertWeiToEth(BigInt.from(1234567890000000000));

      // Assert
      Decimal expectedETHAmount = Decimal.parse('1.23456789');

      expect(actualETHAmount, expectedETHAmount);
    });

    test('Should [convert large wei amount] to the correct ETH amount', () {
      // Act
      Decimal actualETHAmount = EthereumUtils.convertWeiToEth(BigInt.parse('123456789012345678901234567890'));

      // Assert
      Decimal expectedETHAmount = Decimal.parse('123456789012.34567890123456789');

      expect(actualETHAmount, expectedETHAmount);
    });
  });
}
