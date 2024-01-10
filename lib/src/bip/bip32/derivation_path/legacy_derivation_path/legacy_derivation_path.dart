import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

/// [LegacyDerivationPath] represents traditional derivation path used, for example, in Bitcoin, Ethereum, Cosmos and other blockchains.
/// Derivation path defines a logical hierarchy for deterministic wallets (BIP-44) based on an algorithm described in BIP-32 and purpose scheme described in BIP-43.
/// [LegacyDerivationPath] contains a list of [LegacyDerivationPathElement] where each element represents a single level of the following path structure:
/// m / purpose' / coin_type' / account' / change / address_index
///
/// https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki
/// https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki
/// https://github.com/bitcoin/bips/blob/master/bip-0043.mediawiki
class LegacyDerivationPath extends Equatable {
  static const String _masterChar = 'm';

  final List<LegacyDerivationPathElement> pathElements;

  LegacyDerivationPath({
    List<LegacyDerivationPathElement>? pathElements,
  }) : pathElements = pathElements ?? List<LegacyDerivationPathElement>.empty(growable: true);

  /// Parses a derivation path from a string in the format of
  /// "m/purpose'/coin_type'/account'/change/address_index".
  factory LegacyDerivationPath.parse(String derivationPath) {
    String parsedPath = derivationPath;
    if (parsedPath.endsWith('/')) {
      parsedPath = parsedPath.substring(0, parsedPath.length - 1);
    }

    List<String> separatedPath = parsedPath.split('/').where((String elem) => elem.isNotEmpty).toList();
    if (separatedPath.isEmpty || separatedPath.first != _masterChar) {
      throw FormatException('Invalid BIP32 derivation path ($derivationPath)');
    }

    List<LegacyDerivationPathElement> pathElements = separatedPath.sublist(1).map((String e) {
      return LegacyDerivationPathElement.parse(e);
    }).toList();
    return LegacyDerivationPath(pathElements: pathElements);
  }

  @override
  String toString() {
    List<String> separatedPath = <String>[_masterChar, ...pathElements.map((LegacyDerivationPathElement e) => e.toString())];
    return separatedPath.join('/');
  }

  @override
  List<Object?> get props => <Object?>[pathElements];
}
