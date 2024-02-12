import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/bip/bip32/derivators/derivator_type.dart';

abstract class ADerivator {
  static ADerivator fromSerializedType(String type) {
    DerivatorType derivatorType = DerivatorType.values.byName(type);
    return switch (derivatorType) {
      DerivatorType.secp256k1 => Secp256k1Derivator(),
      DerivatorType.substrateED25519 => SubstrateED25519Derivator(),
      DerivatorType.substrateSR25519 => SubstrateSR25519Derivator(),
    };
  }

  String serializeType() {
    return derivatorType.name;
  }

  DerivatorType get derivatorType;
}
