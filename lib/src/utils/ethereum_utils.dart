import 'package:decimal/decimal.dart';

class EthereumUtils {
  static const String weiSymbol = 'wei';
  static const String ethSymbol = 'ETH';
  static Decimal weiInETH = Decimal.parse('1000000000000000000');

  static Decimal convertWeiToEth(BigInt gweiAmount) {
    if (gweiAmount == BigInt.zero) {
      return Decimal.zero;
    }
    Decimal weiAmountDecimal = Decimal.parse(gweiAmount.toString());
    return (weiAmountDecimal / weiInETH).toDecimal();
  }
}
