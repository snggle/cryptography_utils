import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter/material.dart';

@optionalTypeArgs
abstract interface class ISubstrateDerivator<T extends IBip32PrivateKey> implements IDerivator {
  Future<T> derivePath(SubstrateDerivationPath derivationPath);

  Future<T> deriveMasterKey(SubstrateDerivationPath derivationPath);

  T deriveChildKey(T privateKey, SubstrateDerivationPathElement derivationPathElement);
}
