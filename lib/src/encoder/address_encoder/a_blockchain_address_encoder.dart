import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/encoder/address_encoder/address_encoder_type.dart';

/// The [ABlockchainAddressEncoder] class is designed for encode addresses in accordance with the specific blockchain network.
abstract class ABlockchainAddressEncoder<T extends ABip32PublicKey> {
  static ABlockchainAddressEncoder<ABip32PublicKey> fromType(String type) {
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
    };
  }

  String toType() {
    return '${addressEncoderType.name}(${args.join(',')})';
  }

  String encodePublicKey(T publicKey);

  List<String> get args;

  AddressEncoderType get addressEncoderType;
}
