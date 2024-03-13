import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter/material.dart';

@optionalTypeArgs
abstract interface class ILegacyDerivator<T extends IBip32PrivateKey> implements IDerivator {
  Future<T> derivePath(Mnemonic mnemonic, LegacyDerivationPath legacyDerivationPath);

  Future<T> deriveMasterKey(Mnemonic mnemonic);

  T deriveChildKey(T privateKey, LegacyDerivationPathElement derivationPathElement);
}
