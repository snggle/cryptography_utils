import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/substrate/ss58_encoder.dart';

/// The [SubstrateSR25519AddressEncoder] class is designed for encoding addresses within the Substrate framework using the SR25519 public key
/// Substrate addresses are encoded using the SS58 encoding scheme, which differentiates between networks with a network prefix.
/// The SS58 address format is detailed in the Substrate documentation:
/// https://docs.substrate.io/reference/address-formats/
class SubstrateSR25519AddressEncoder extends ABlockchainAddressEncoder<SR25519PublicKey> {
  final int ss58Format;

  SubstrateSR25519AddressEncoder({
    required this.ss58Format,
  });

  @override
  AddressEncoderType get addressEncoderType => AddressEncoderType.substrateSR25519;

  @override
  List<String> get args => <String>[ss58Format.toString()];


  @override
  String encodePublicKey(SR25519PublicKey publicKey) {
    return SS58Encoder.encode(publicKey.bytes, ss58Format);
  }
}
