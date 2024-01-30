import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter/foundation.dart';

/// Abstract class for mnemonic seed generators.
/// Contains shared method to calculate seed from mnemonic in separated thread.
abstract class AMnemonicSeedGenerator {
  final int seedLength;

  AMnemonicSeedGenerator({required this.seedLength});

  Future<Uint8List> generateSeed(Mnemonic mnemonic, {String passphrase = ''});

  @protected
  Future<Uint8List> computeSeed({
    required Uint8List password,
    required Uint8List salt,
  }) async {
    return compute(_computeSeed, <dynamic>[seedLength, password, salt]);
  }
}

// This function is executed in a separated isolate, so it should be declared as a top-level function
Future<Uint8List> _computeSeed(List<dynamic> props) async {
  assert(props.length == 3, 'Using [_computeSeed] method require list with three values [password, salt, length]');

  int seedLength = props[0] as int;
  Uint8List password = props[1] as Uint8List;
  Uint8List salt = props[2] as Uint8List;

  PBKDF2 pbkdf2 = PBKDF2(outputLength: seedLength);
  Uint8List seed = pbkdf2.process(password, salt);

  return seed;
}
