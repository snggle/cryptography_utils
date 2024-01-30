import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter/foundation.dart';

/// Abstract class for mnemonic seed generators
/// Contains shared method to calculate seed from mnemonic in separated thread
abstract class AMnemonicSeedGenerator {
  final int length;

  AMnemonicSeedGenerator({required this.length});

  Future<Uint8List> calculateSeed(Mnemonic mnemonic, {String passphrase = ''});

  @protected
  Future<Uint8List> computeMnemonicSeed({
    required Uint8List password,
    required Uint8List salt,
  }) async {
    return compute(_computeMnemonicSeed, <dynamic>[length, password, salt]);
  }
}

// This function is executed in a separated isolate, so it should be declared as a top-level function
Future<Uint8List> _computeMnemonicSeed(List<dynamic> props) async {
  assert(props.length == 3, 'Using [_computeMnemonicSeed] method require list with three values [password, salt, length]');

  int length = props[0] as int;
  Uint8List password = props[1] as Uint8List;
  Uint8List salt = props[2] as Uint8List;

  PBKDF2 pbkdf2 = PBKDF2(length: length);
  Uint8List seed = pbkdf2.process(password, salt);

  return seed;
}
