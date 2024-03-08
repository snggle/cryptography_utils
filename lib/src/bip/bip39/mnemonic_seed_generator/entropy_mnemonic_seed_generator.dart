import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// The [EntropyMnemonicSeedGenerator] class provides functionality to generate mnemonic seeds based on entropy.
/// It's used in various cryptographic applications, especially in the blockchain networks based on Substrate (e.g. Polkadot).
class EntropyMnemonicSeedGenerator extends AMnemonicSeedGenerator {
  static const String _defaultSalt = 'mnemonic';

  EntropyMnemonicSeedGenerator({
    int seedLength = 32,
  }) : super(seedLength: seedLength);

  @override
  Future<Uint8List> generateSeed(Mnemonic mnemonic, {String passphrase = ''}) async {
    Uint8List password = mnemonic.entropy;
    Uint8List salt = Uint8List.fromList('$_defaultSalt$passphrase'.codeUnits);
    return computeSeed(password: password, salt: salt);
  }
}
