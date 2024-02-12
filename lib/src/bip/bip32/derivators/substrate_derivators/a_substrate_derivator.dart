import 'package:cryptography_utils/cryptography_utils.dart';

abstract class ASubstrateDerivator<T extends ABip32PrivateKey> extends ADerivator {
  Future<T> derivePath(SubstrateDerivationPath derivationPath);

  Future<T> deriveMasterKey(SubstrateDerivationPath derivationPath);

  T deriveChildKey(T privateKey, SubstrateDerivationPathElement derivationPathElement);
}
