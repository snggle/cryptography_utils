import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// The [SubstrateSeedGenerator] class provides functionality to generate mnemonic seeds based on entropy with specific cases for Substrate
class SubstrateSeedGenerator {
  Future<Uint8List> calculateSeed(SubstrateDerivationPath substrateDerivationPath) async {
    bool pharseHexBool = HexCodec.isHex(substrateDerivationPath.pharse);
    if (pharseHexBool) {
      return HexCodec.decode(substrateDerivationPath.pharse);
    }

    try {
      Mnemonic mnemonic = Mnemonic.fromMnemonicPhrase(substrateDerivationPath.pharse);
      return EntropyMnemonicSeedGenerator(seedLength: 32).generateSeed(mnemonic, passphrase: substrateDerivationPath.password);
    } catch (e) {
      throw ArgumentError('Invalid mnemonic: $e');
    }
  }
}
