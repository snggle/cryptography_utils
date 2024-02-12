import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// The [SubstrateSeedGenerator] class provides functionality to generate mnemonic seeds based on entropy with specific cases for Substrate
class SubstrateSeedGenerator {
  Future<Uint8List> calculateSeed(SubstrateDerivationPath substrateDerivationPath) async {
    bool pharseHexBool = Hex().isHex(substrateDerivationPath.pharse);
    if (pharseHexBool) {
      return Hex().decode(substrateDerivationPath.pharse);
    }

    Mnemonic mnemonic = Mnemonic.fromString(substrateDerivationPath.pharse);
    if (mnemonic.isValid) {
      return EntropyMnemonicSeedGenerator(seedLength: 32).generateSeed(mnemonic, passphrase: substrateDerivationPath.password);
    } else {
      throw ArgumentError('Invalid mnemonic');
    }
  }
}
