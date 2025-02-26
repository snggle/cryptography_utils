import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/binary_utils.dart';
import 'package:cryptography_utils/src/utils/secure_random.dart';
import 'package:equatable/equatable.dart';

/// The [Mnemonic] class is designed for handling mnemonic phrases, which are human-readable sequences of words used to generate and recover cryptographic keys.
/// This functionality is typically used in the context of cryptocurrency wallets for generating private-keys in a way that is easier for users to record and remember.
/// https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki
class Mnemonic extends Equatable {
  static const int _mnemonicWordNotFoundInDictionary = -1;
  final List<String> mnemonicList;

  // Validation of a mnemonic phrase requires to check its length, checksum and words.
  // To do this before a Mnemonic object is created, you can use the isValidMnemonic static method.
  // Exceptions are left in the constructor mainly in case we want to tell a user the reason why a mnemonic is invalid.
  Mnemonic(this.mnemonicList) {
    if (mnemonicList.length % 3 != 0 || mnemonicList.isEmpty) {
      throw const MnemonicException(MnemonicExceptionType.invalidLength);
    } else if (_parseWordsToWordIndexes(mnemonicList).contains(_mnemonicWordNotFoundInDictionary)) {
      throw const MnemonicException(MnemonicExceptionType.invalidWord);
    }

    String extractedChecksum = _extractChecksum(mnemonicList);
    String calculatedChecksum = _calculateChecksum(entropy);

    if (extractedChecksum != calculatedChecksum) {
      throw const MnemonicException(MnemonicExceptionType.invalidChecksum);
    }
  }

  /// Generates a new [Mnemonic] object of the specified size.
  factory Mnemonic.generate({required MnemonicSize mnemonicSize}) {
    Uint8List entropy = SecureRandom.getBytes(length: mnemonicSize.entropyBytesSize, max: 255);

    return Mnemonic.fromEntropy(entropy);
  }

  /// Constructs a new [Mnemonic] object from the entropy.
  factory Mnemonic.fromEntropy(Uint8List entropy) {
    String entropyBits = BinaryUtils.bytesToBinary(entropy);
    String checksumBits = _calculateChecksum(entropy);
    String mnemonicBits = entropyBits + checksumBits;

    List<String> mnemonicListBinaries = BinaryUtils.splitBinary(mnemonicBits, 11);
    List<int> mnemonicListIndexes = mnemonicListBinaries.map(BinaryUtils.binaryToInt).toList();
    List<String> mnemonicList = mnemonicListIndexes.map((int index) => MnemonicDictionary.english[index]).toList();

    return Mnemonic(mnemonicList);
  }

  /// Constructs a new [Mnemonic] object from the mnemonic phrase.
  factory Mnemonic.fromMnemonicPhrase(String mnemonicPhrase, {String delimiter = ' '}) {
    List<String> mnemonicList = mnemonicPhrase.split(delimiter);

    return Mnemonic(mnemonicList);
  }

  /// Validates a mnemonic phrase without creating an object of the Mnemonic class.
  static bool isValidMnemonic(List<String> mnemonicList) {
    Uint8List entropy = _calcEntropy(mnemonicList);

    String extractedChecksum = _extractChecksum(mnemonicList);
    String calculatedChecksum = _calculateChecksum(entropy);

    if (extractedChecksum != calculatedChecksum || extractedChecksum == '0') {
      return false;
    }

    return true;
  }

  @override
  String toString() {
    return mnemonicList.join(' ');
  }

  Uint8List get entropy => _calcEntropy(mnemonicList);

  /// Returns the entropy of the mnemonic phrase.
  static Uint8List _calcEntropy(List<String> mnemonicList) {
    String mnemonicBits = _parseWordsToBits(mnemonicList);

    int entropyStartIndex = 0;
    int entropyEndIndex = (mnemonicBits.length / 33).floor() * 32;

    String entropyBits = mnemonicBits.substring(entropyStartIndex, entropyEndIndex);
    List<String> entropyBinaries = BinaryUtils.splitBinary(entropyBits, 8);
    Uint8List entropy = Uint8List.fromList(entropyBinaries.map(BinaryUtils.binaryToInt).toList());

    return entropy;
  }

  /// Calculates the checksum of the mnemonic phrase basing on given entropy.
  static String _calculateChecksum(Uint8List entropy) {
    int entropyBitsLength = entropy.length * 8;
    int checksumSize = entropyBitsLength ~/ 32;
    List<int> hash = Sha256().convert(entropy).byteList;

    return BinaryUtils.bytesToBinary(hash).substring(0, checksumSize);
  }

  /// Returns binary checksum included in the last word of the mnemonic phrase.
  static String _extractChecksum(List<String> mnemonicList) {
    String mnemonicBits = _parseWordsToBits(mnemonicList);

    int checksumStartIndex = (mnemonicBits.length / 33).floor() * 32;
    int checksumEndIndex = mnemonicBits.length;

    String checksum = mnemonicBits.substring(checksumStartIndex, checksumEndIndex);

    return checksum;
  }

  /// Returns the combined mnemonic words in binary format.
  static String _parseWordsToBits(List<String> mnemonicList) {
    List<int> mnemonicListIndexes = mnemonicList.map(MnemonicDictionary.english.indexOf).toList();
    List<String> mnemonicListBinaries = mnemonicListIndexes.map((int index) => BinaryUtils.intToBinary(index, padding: 11)).toList();
    String mnemonicBits = mnemonicListBinaries.join('');

    return mnemonicBits;
  }

  /// Returns dictionary indexes of the mnemonic words.
  /// If a word is not found in the dictionary, it will be represented as -1.
  static List<int> _parseWordsToWordIndexes(List<String> mnemonicList) {
    return mnemonicList.map(MnemonicDictionary.english.indexOf).toList();
  }

  @override
  List<Object?> get props => <Object>[mnemonicList];
}
