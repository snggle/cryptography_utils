import 'package:equatable/equatable.dart';

/// [MnemonicSize] defines the relationship between the number of words in a mnemonic phrase and its corresponding entropy size in bits.
/// Supported sizes include 12, 15, 18, 21, and 24 words, corresponding to entropy sizes of 128, 160, 192, 224, and 256 bits, respectively.
class MnemonicSize extends Equatable {
  static MnemonicSize words12 = const MnemonicSize(12, 128);
  static MnemonicSize words15 = const MnemonicSize(15, 160);
  static MnemonicSize words18 = const MnemonicSize(18, 192);
  static MnemonicSize words21 = const MnemonicSize(21, 224);
  static MnemonicSize words24 = const MnemonicSize(24, 256);

  /// The amount of words in the mnemonic phrase.
  final int wordCount;

  /// The size of the entropy in bits.
  final int entropyBitsSize;

  const MnemonicSize(this.wordCount, this.entropyBitsSize);

  /// Returns the size of the entropy in bytes.
  int get entropyBytesSize => entropyBitsSize ~/ 8;

  @override
  List<Object?> get props => <Object?>[wordCount, entropyBitsSize];
}
