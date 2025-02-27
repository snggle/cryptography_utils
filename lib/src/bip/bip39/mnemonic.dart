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
  // To do this before the object is created - in the factory constructor, all public methods contained in this class must be static,
  // Such a solution would be less readable and less intuitive. For that reason, the validation and exception throwing are done in the constructor.
  Mnemonic(this.mnemonicList) {
    if (mnemonicList.length % 3 != 0 || mnemonicList.isEmpty) {
      throw const MnemonicException(MnemonicExceptionType.invalidLength);
    } else if (_mnemonicListIndexes.contains(_mnemonicWordNotFoundInDictionary)) {
      throw const MnemonicException(MnemonicExceptionType.invalidWord);
    }

    String extractedChecksum = _extractChecksum();
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

  /// Returns the entropy of the mnemonic phrase.
  Uint8List get entropy {
    String mnemonicBits = _mnemonicBits;

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
  String _extractChecksum() {
    String mnemonicBits = _mnemonicBits;

    int checksumStartIndex = (mnemonicBits.length / 33).floor() * 32;
    int checksumEndIndex = mnemonicBits.length;

    String checksum = mnemonicBits.substring(checksumStartIndex, checksumEndIndex);

    return checksum;
  }

  /// Returns the combined mnemonic words in binary format.
  String get _mnemonicBits {
    List<String> mnemonicListBinaries = _mnemonicListIndexes.map((int index) => BinaryUtils.intToBinary(index, padding: 11)).toList();
    String mnemonicBits = mnemonicListBinaries.join('');

    return mnemonicBits;
  }

  /// Returns dictionary indexes of the mnemonic words.
  /// If a word is not found in the dictionary, it will be represented as -1.
  List<int> get _mnemonicListIndexes => mnemonicList.map(MnemonicDictionary.english.indexOf).toList();

  @override
  String toString() {
    return mnemonicList.join(' ');
  }

  @override
  List<Object?> get props => <Object>[mnemonicList];
}
