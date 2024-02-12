import 'package:cryptography_utils/cryptography_utils.dart';

/// The [ABlockchainAddressEncoder] class is designed for encoding addresses in accordance with the specific blockchain network.
abstract class ABlockchainAddressEncoder<T extends ABip32PublicKey> {
  static ABlockchainAddressEncoder<ABip32PublicKey> fromSerializedType(String type) {
    RegExp regExp = RegExp(r'(\w+)\((.*?)\)');
    RegExpMatch? match = regExp.firstMatch(type);

    AddressEncoderType? addressEncoderType = AddressEncoderType.values.byName(match!.group(1) as String);
    List<String> args = match.group(2)!.split(',').toList();

    return switch (addressEncoderType) {
      AddressEncoderType.bitcoinP2PKH => BitcoinP2PKHAddressEncoder(publicKeyMode: PublicKeyMode.values.byName(args[0])),
      AddressEncoderType.bitcoinP2SH => BitcoinP2SHAddressEncoder(),
      AddressEncoderType.bitcoinP2WPKH => BitcoinP2WPKHAddressEncoder(hrp: args[0]),
      AddressEncoderType.cosmos => CosmosAddressEncoder(hrp: args[0]),
      AddressEncoderType.ethereum => EthereumAddressEncoder(skipChecksumBool: args[0] == 'true'),
      AddressEncoderType.substrateED25519 => SubstrateED25519AddressEncoder(ss58Format: int.parse(args[0])),
      AddressEncoderType.substrateSR25519 => SubstrateSR25519AddressEncoder(ss58Format: int.parse(args[0])),
    }  as ABlockchainAddressEncoder<ABip32PublicKey>;
  }

  String serializeType() {
    return '${addressEncoderType.name}(${args.join(',')})';
  }

  AddressEncoderType get addressEncoderType;

  List<String> get args;

  String encodePublicKey(T publicKey);
}
