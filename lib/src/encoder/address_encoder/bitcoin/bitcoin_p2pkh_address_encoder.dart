import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// The [BitcoinP2PKHAddressEncoder] class is designed for encoding P2PKH (Pay-to-PubKey-Hash) addresses in accordance with Bitcoin.
/// P2SH addresses utilize the RIPEMD-160 and SHA-256 hash functions to generate addresses from a script's hash.
/// Through these methods, it produces addresses prefixed with '1 and encoded with Base58Check'.
class BitcoinP2PKHAddressEncoder implements IBlockchainAddressEncoder<Secp256k1PublicKey> {
  static const List<int> _networkVersionBytes = <int>[0x00];
  final PublicKeyMode publicKeyMode;

  BitcoinP2PKHAddressEncoder({
    this.publicKeyMode = PublicKeyMode.compressed,
  });

  @override
  String encodePublicKey(Secp256k1PublicKey publicKey) {
    Uint8List publicKeyBytes = publicKeyMode == PublicKeyMode.compressed ? publicKey.compressed : publicKey.uncompressed;

    Uint8List publicKeyFingerprint = Uint8List.fromList(sha256.convert(publicKeyBytes).bytes);
    Uint8List publicKeyHash = Ripemd160().process(publicKeyFingerprint);

    return Base58Encoder.encodeWithChecksum(Uint8List.fromList(<int>[..._networkVersionBytes, ...publicKeyHash]));
  }
}
