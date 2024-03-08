import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter/foundation.dart';

/// The [LegacyMnemonicSeedGenerator] class provides functionality to generate mnemonic seed using traditional method based on mnemonic phrase.
/// It's used in various cryptographic applications like Bitcoin, Ethereum or Cosmos.
class LegacyMnemonicSeedGenerator extends AMnemonicSeedGenerator {
  static const String _defaultSalt = 'mnemonic';

  LegacyMnemonicSeedGenerator({
    int seedLength = 64,
  }) : super(seedLength: seedLength);

  @override
  Future<Uint8List> generateSeed(Mnemonic mnemonic, {String passphrase = ''}) async {
    Uint8List password = Uint8List.fromList(mnemonic.toString().codeUnits);
    Uint8List salt = Uint8List.fromList('$_defaultSalt$passphrase'.codeUnits);
    return computeSeed(password: password, salt: salt);
  }
}
