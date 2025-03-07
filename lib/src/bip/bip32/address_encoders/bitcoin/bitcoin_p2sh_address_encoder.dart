import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// The [BitcoinP2SHAddressEncoder] class is designed for encoding P2SH (Pay-to-Script-Hash) addresses in accordance with Bitcoin.
/// P2SH addresses utilize the RIPEMD-160 and SHA-256 hash functions to generate addresses from a script's hash.
/// Through these methods, it produces addresses prefixed with '3 and encoded with Base58Check'.
class BitcoinP2SHAddressEncoder extends ABlockchainAddressEncoder<Secp256k1PublicKey> {
  static const List<int> _networkVersionBytes = <int>[0x05];
  static const List<int> _scriptBytes = <int>[0x00, 0x14];

  @override
  AddressEncoderType get addressEncoderType => AddressEncoderType.bitcoinP2SH;

  @override
  List<String> get args => <String>[];

  @override
  String encodePublicKey(Secp256k1PublicKey publicKey) {
    /// Generate the script signature from the public key.
    List<int> scriptSignatureBytes = _addScriptSignature(publicKey);

    return Base58Codec.encodeWithChecksum(Uint8List.fromList(<int>[..._networkVersionBytes, ...scriptSignatureBytes]));
  }

  List<int> _addScriptSignature(Secp256k1PublicKey publicKey) {
    Uint8List publicKeyFingerprint = Sha256().convert(publicKey.compressed).byteList;
    Uint8List publicKeyHash = Ripemd160().process(publicKeyFingerprint);

    Uint8List signatureBytes = Uint8List.fromList(<int>[..._scriptBytes, ...publicKeyHash]);
    Uint8List signatureFingerprint = Sha256().convert(signatureBytes).byteList;
    Uint8List signatureHash = Ripemd160().process(signatureFingerprint);

    return signatureHash;
  }
}
