import 'package:cryptography_utils/cryptography_utils.dart';

abstract interface class ISubstrateDerivator<T extends ABip32PrivateKey> implements IDerivator {
  Future<T> derivePath(SubstrateDerivationPath derivationPath);

  Future<T> deriveMasterKey(SubstrateDerivationPath derivationPath);

  T deriveChildKey(T privateKey, SubstrateDerivationPathElement derivationPathElement);
}
