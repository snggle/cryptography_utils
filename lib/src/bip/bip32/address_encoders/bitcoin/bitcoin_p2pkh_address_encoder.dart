import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// The [BitcoinP2PKHAddressEncoder] class is designed for encoding P2PKH (Pay-to-PubKey-Hash) addresses in accordance with Bitcoin.
/// P2SH addresses utilize the RIPEMD-160 and SHA-256 hash functions to generate addresses from a script's hash.
/// Through these methods, it produces addresses prefixed with '1 and encoded with Base58Check'.
class BitcoinP2PKHAddressEncoder extends ABlockchainAddressEncoder<Secp256k1PublicKey> {
  static const List<int> _networkVersionBytes = <int>[0x00];

  final PublicKeyMode publicKeyMode;

  BitcoinP2PKHAddressEncoder({
    this.publicKeyMode = PublicKeyMode.compressed,
  });

  @override
  AddressEncoderType get addressEncoderType => AddressEncoderType.bitcoinP2PKH;

  @override
  List<String> get args => <String>[publicKeyMode.name];

  @override
  String encodePublicKey(Secp256k1PublicKey publicKey) {
    Uint8List publicKeyBytes = publicKeyMode == PublicKeyMode.compressed ? publicKey.compressed : publicKey.uncompressed;

    Uint8List publicKeyFingerprint = Sha256().convert(publicKeyBytes).byteList;
    Uint8List publicKeyHash = Ripemd160().process(publicKeyFingerprint);

    return Base58Codec.encodeWithChecksum(Uint8List.fromList(<int>[..._networkVersionBytes, ...publicKeyHash]));
  }
}
