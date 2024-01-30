import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// The [Mnemonic] class is designed for handling mnemonic phrases, which are human-readable sequences of words used to generate and recover cryptographic keys.
/// This functionality is typically used in the context of cryptocurrency wallets for generating private-keys in a way that is easier for users to record and remember.
/// https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki
class Mnemonic extends Equatable {
  final List<String> mnemonicList;

  const Mnemonic(this.mnemonicList);

  /// Generates a new random mnemonic phrase of the specified size.
  factory Mnemonic.generate({required MnemonicSize mnemonicSize}) {
    Uint8List entropy = SecureRandom.getBytes(length: mnemonicSize.entropyBytesSize, max: 255);
    return Mnemonic.fromEntropy(entropy);
  }

  /// Generates a new mnemonic phrase from the provided entropy.
  factory Mnemonic.fromEntropy(Uint8List entropy) {
    String entropyBits = BinaryUtils.bytesToBinary(entropy);
    String checksumBits = _calcBinaryChecksum(entropy);
    String mnemonicBits = entropyBits + checksumBits;

    List<String> wordBinaries = BinaryUtils.splitBinary(mnemonicBits, 11);

    List<int> wordIndexes = wordBinaries.map(BinaryUtils.binaryToInt).toList();
    List<String> words = wordIndexes.map((int index) => MnemonicDictionary.english[index]).toList();

    return Mnemonic(words);
  }

  /// Parses a mnemonic phrase from a string.
  Mnemonic.fromString(String mnemonicString, {String delimiter = ' '}) : mnemonicList = mnemonicString.split(delimiter);

  bool get isValid {
    try {
      Uint8List tmpEntropy = entropy;
      return tmpEntropy.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Uint8List get entropy {
    if (mnemonicList.length % 3 != 0) {
      throw Exception('Invalid mnemonic');
    }

    List<int> wordIndexes = mnemonicList.map(MnemonicDictionary.english.indexOf).toList();
    if (wordIndexes.contains(-1)) {
      throw Exception('Invalid mnemonic');
    }

    List<String> wordBinaries = wordIndexes.map((int index) => BinaryUtils.intToBinary(index, padding: 11)).toList();
    String mnemonicBits = wordBinaries.join('');

    int dividerIndex = (mnemonicBits.length / 33).floor() * 32;
    String entropyBits = mnemonicBits.substring(0, dividerIndex);
    String expectedChecksumBits = mnemonicBits.substring(dividerIndex);

    List<String> entropyBinaries = BinaryUtils.splitBinary(entropyBits, 8);
    Uint8List entropy = Uint8List.fromList(entropyBinaries.map(BinaryUtils.binaryToInt).toList());

    String actualChecksumBits = _calcBinaryChecksum(entropy);
    if (actualChecksumBits != expectedChecksumBits) {
      throw Exception('Invalid checksum');
    }

    return entropy;
  }

  int get length => mnemonicList.length;

  static String _calcBinaryChecksum(Uint8List entropy) {
    int entropyBitsLength = entropy.length * 8;
    int checksumSize = entropyBitsLength ~/ 32;
    List<int> hash = sha256.convert(entropy).bytes;
    return BinaryUtils.bytesToBinary(hash).substring(0, checksumSize);
  }

  @override
  String toString() {
    return mnemonicList.join(' ');
  }

  @override
  List<Object?> get props => <Object>[mnemonicList];
}
