import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// The [EthereumAddressEncoder] class is designed for encoding addresses in accordance with the Ethereum network.
/// Ethereum uses the Keccak-256 hash function to generate addresses from public keys, resulting in 40 hexadecimal characters prefixed with "0x".
/// https://info.etherscan.com/what-is-an-ethereum-address/
class EthereumAddressEncoder extends ABlockchainAddressEncoder<Secp256k1PublicKey> {
  static const int _startByte = 24;

  final bool skipChecksumBool;

  EthereumAddressEncoder({
    this.skipChecksumBool = false,
  });

  @override
  AddressEncoderType get addressEncoderType => AddressEncoderType.ethereum;

  @override
  List<String> get args => <String>[skipChecksumBool.toString()];

  @override
  String encodePublicKey(Secp256k1PublicKey publicKey) {
    Uint8List keccakHash = Keccak(256).process(publicKey.uncompressed.sublist(1));
    String keccakHex = HexCodec.encode(keccakHash, lowercaseBool: true);

    String address = keccakHex.substring(_startByte);
    if (skipChecksumBool) {
      return '0x${address}';
    }
    return '0x${_wrapWithChecksum(address)}';
  }

  static String _wrapWithChecksum(String address) {
    Uint8List addressBytes = utf8.encode(address.toLowerCase());
    Uint8List checksumBytes = Keccak(256).process(addressBytes);
    String checksumHex = HexCodec.encode(checksumBytes, lowercaseBool: true);

    List<String> addressWithChecksum = address.split('').asMap().entries.map((MapEntry<int, String> entry) {
      int index = entry.key;
      String char = entry.value;
      int charChecksumHex = int.parse(checksumHex[index], radix: 16);
      return charChecksumHex >= 8 ? char.toUpperCase() : char.toLowerCase();
    }).toList();

    return addressWithChecksum.join();
  }
}
