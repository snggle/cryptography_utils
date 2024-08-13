import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/bip/bip32/derivators/a_derivator.dart';

abstract class ALegacyDerivator<T extends ABip32PrivateKey> extends ADerivator {
  Future<T> derivePath(Mnemonic mnemonic, LegacyDerivationPath legacyDerivationPath);

  Future<T> deriveMasterKey(Mnemonic mnemonic);

  T deriveChildKey(T privateKey, LegacyDerivationPathElement derivationPathElement);
}
