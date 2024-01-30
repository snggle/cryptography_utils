import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter/foundation.dart';

/// The [LegacyMnemonicSeedGenerator] class provides functionality to generate mnemonic seed using traditional method based on mnemonic pharse
/// It's used in various cryptographic applications like Cosmos, Ethereum or Bitcoin.
class LegacyMnemonicSeedGenerator extends AMnemonicSeedGenerator {
  static const String _defaultSalt = 'mnemonic';

  LegacyMnemonicSeedGenerator({
    int length = 64,
  }) : super(length: length);

  @override
  Future<Uint8List> calculateSeed(Mnemonic mnemonic, {String passphrase = ''}) async {
    Uint8List password = Uint8List.fromList(mnemonic.toString().codeUnits);
    Uint8List salt = Uint8List.fromList('$_defaultSalt$passphrase'.codeUnits);
    return computeMnemonicSeed(password: password, salt: salt);
  }
}
