import 'dart:convert';
import 'dart:typed_data';

/// Stores HMAC keys used in BIP-32 derivations.
class Bip32HMACKeys {
  static Uint8List get hmacKeySecp256k1Bytes => utf8.encode('Bitcoin seed');
}
