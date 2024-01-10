import 'dart:typed_data';

class BigIntUtils {
  static Uint8List changeToBytes(BigInt value, {int? length}) {
    int byteLength = length ?? calculateByteLength(value);

    BigInt updatedValue = value;
    BigInt bigMaskEight = BigInt.from(0xff);
    if (updatedValue == BigInt.zero) {
      return Uint8List.fromList(List<int>.filled(byteLength, 0));
    }
    List<int> byteList = List<int>.filled(byteLength, 0);
    for (int i = 0; i < byteLength; i++) {
      byteList[byteLength - i - 1] = (updatedValue & bigMaskEight).toInt();
      updatedValue = updatedValue >> 8;
    }

    return Uint8List.fromList(byteList);
  }

  static int calculateByteLength(BigInt value) {
    String valueHex = value.toRadixString(16);
    int byteLength = (valueHex.length + 1) ~/ 2;
    return byteLength;
  }

  static List<BigInt> computeNAF(BigInt multiplier) {
    BigInt updatedMultiplier = multiplier;
    List<BigInt> nafList = <BigInt>[];

    while (updatedMultiplier != BigInt.zero) {
      if (updatedMultiplier.isOdd) {
        BigInt nafDigit = updatedMultiplier % BigInt.from(4);

        if (nafDigit >= BigInt.two) {
          nafDigit -= BigInt.from(4);
        }

        nafList.add(nafDigit);
        updatedMultiplier -= nafDigit;
      } else {
        nafList.add(BigInt.zero);
      }

      updatedMultiplier ~/= BigInt.two;
    }

    return nafList;
  }

  static BigInt decode(List<int> bytes, {int? bitLength}) {
    int bytesBitLength = bytes.length * 8;

    BigInt result = BigInt.zero;
    for (int i = 0; i < bytes.length; i++) {
      result += BigInt.from(bytes[i]) << ((bytes.length - i - 1) * 8);
    }

    if (bitLength != null && bytesBitLength >= bitLength) {
      result >>= bytesBitLength - bitLength;
    }
    return result;
  }
}
