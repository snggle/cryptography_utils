import 'package:cryptography_utils/src/bip/bip32/derivation_path/substrate_derivation_path/substrate_derivation_path_element.dart';
import 'package:equatable/equatable.dart';

/// Represents derivation paths using Substrate's SURI (Secret URI) format for hierarchical deterministic (HD) wallets.
/// The SURI format allows specifying a secret seed, derivation paths (both soft and hard), and an optional password in a single string.
/// This class supports parsing and managing these components, with paths denoted by `/<soft-key>`, `//<hard-key>`, and the optional `///<password>`
class SubstrateDerivationPath extends Equatable {
  static final RegExp _uriRegex = RegExp(r'^(?<phrase>[\d\w ]+)?(?<path>(//?[^/]+)*)(///(?<password>.*))?$');
  static final RegExp _elementRegex = RegExp('/(/?[^/]+)');

  final String secretUri;
  final String pharse;
  final String? derivationPath;
  final List<SubstrateDerivationPathElement> derivationPathElements;
  final String password;

  const SubstrateDerivationPath({
    required this.secretUri,
    required this.pharse,
    required this.derivationPathElements,
    required this.derivationPath,
    String? password,
  }) : password = password ?? '';

  /// Extracts the phrase, path and password from a SURI format for specifying secret keys `<secret>/<soft-key>//<hard-key>///<password>`
  /// (the `///password` may be omitted, and `/<soft-key>` and `//<hard-key>` may be repeated and mixed).
  factory SubstrateDerivationPath.fromUri(String secretUri) {
    RegExpMatch? match = _uriRegex.firstMatch(secretUri);
    if (match == null) {
      throw Exception('Unable to match provided value to a secret URI');
    }

    String? phase = match.namedGroup('phrase');
    if (phase == null || phase.isEmpty) {
      throw const FormatException('Phrase is required');
    }

    List<SubstrateDerivationPathElement> elements = _elementRegex.allMatches(match.namedGroup('path')!).map((RegExpMatch match) {
      return SubstrateDerivationPathElement.fromString(match.group(1)!);
    }).toList();

    return SubstrateDerivationPath(
      secretUri: secretUri,
      pharse: match.namedGroup('phrase')!,
      derivationPath: match.namedGroup('path'),
      derivationPathElements: elements,
      password: match.namedGroup('password'),
    );
  }

  @override
  List<Object?> get props => <Object?>[secretUri, pharse, derivationPath, password];
}
