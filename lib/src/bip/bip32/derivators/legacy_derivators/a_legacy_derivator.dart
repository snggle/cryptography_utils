import 'package:cryptography_utils/cryptography_utils.dart';

abstract class ALegacyDerivator<T extends ABip32PrivateKey> extends ADerivator {
  Future<T> derivePath(Mnemonic mnemonic, LegacyDerivationPath legacyDerivationPath);

  Future<T> deriveMasterKey(Mnemonic mnemonic);

  T deriveChildKey(T privateKey, LegacyDerivationPathElement derivationPathElement);
}
