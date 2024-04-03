import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which creates [newAccount] belonging to [source], generated with [base] and [seed],
/// paying [lamports] (SOL) which includes both the staked amount as well as a fee for account creation.
/// The instruction's full name is CreateAccountWithSeed.
///
/// Example instruction: https://solscan.io/tx/29paksPao72yNHhfHUuFDgfm9yzQMe5FDzXz9QSTu5AH7TzKerHHKFbdm7mbuxTZP5cqmLdqXAfWhcpdzXRzuTHE?cluster=devnet
/// {
///     info: {
///         base: "2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19"
///         lamports: 1002282880
///         newAccount: "M9iFmNtBVXLGKX3MRfApAar1g2PJgGvp9FKrs1Qwimc"
///         owner: "Stake11111111111111111111111111111111111111"
///         seed: "stake:3"
///         source: "2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19"
///         space: 200
///     }
///     type: "createAccountWithSeed"
/// }
class SolanaSystemAccountSeedInstruction extends ASolanaInstructionDecoded {
  /// Field order on Solscan is based on unknown rules.
  /// Solscan also ignores the [discriminator] for this instruction, even though it is always present in this instruction's data array.
  ///
  /// Our field order below is NOT influenced by Solscan and follows the order of data received from [SolanaCompiledInstruction]:
  /// - account indexes, in order of appearance in the [SolanaCompiledInstruction] accounts field
  /// - instruction data array values, in order of appearance in [SolanaCompiledInstruction] data field
  final String _source;
  final String _newAccount;
  final int _discriminator;
  final String _base;
  final String _seed;
  final BigInt _lamports;
  final int _space;
  final String _owner;

  const SolanaSystemAccountSeedInstruction({
    required String programId,
    required String source,
    required String newAccount,
    required int discriminator,
    required String base,
    required String seed,
    required BigInt lamports,
    required int space,
    required String owner,
  })  : _source = source,
        _newAccount = newAccount,
        _discriminator = discriminator,
        _base = base,
        _seed = seed,
        _lamports = lamports,
        _space = space,
        _owner = owner,
        super(programId: programId);

  /// Creates a new instance of [SolanaSystemAccountSeedInstruction] from the serialized data.
  factory SolanaSystemAccountSeedInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String source = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String newAccount = accountKeys[solanaCompiledInstruction.accounts[1]].toBase58();

    ByteReader byteReader = ByteReader(solanaCompiledInstruction.data);

    Uint8List discriminatorBytes = byteReader.shiftRightBy(4);
    int discriminator = ByteData.sublistView(discriminatorBytes).getUint32(0, Endian.little);

    Uint8List baseBytes = byteReader.shiftRightBy(32);
    String base = SolanaPubKey.fromBytes(baseBytes).toBase58();

    Uint8List seedLengthBytes = byteReader.shiftRightBy(8);
    int seedLength = ByteData.sublistView(seedLengthBytes).getUint32(0, Endian.little);
    Uint8List seedBytes = byteReader.shiftRightBy(seedLength);
    String seed = utf8.decode(seedBytes);

    Uint8List lamportsBytes = byteReader.shiftRightBy(8);
    int lamportsInt = ByteData.sublistView(lamportsBytes).getUint64(0, Endian.little);
    BigInt lamports = BigInt.from(lamportsInt);

    Uint8List spaceBytes = byteReader.shiftRightBy(8);
    int space = ByteData.sublistView(spaceBytes).getUint64(0, Endian.little);

    Uint8List ownerBytes = byteReader.shiftRightBy(32);
    String owner = SolanaPubKey.fromBytes(ownerBytes).toBase58();

    return SolanaSystemAccountSeedInstruction(
      programId: programId,
      source: source,
      newAccount: newAccount,
      discriminator: discriminator,
      base: base,
      seed: seed,
      lamports: lamports,
      space: space,
      owner: owner,
    );
  }

  @override
  String? get source => _source;

  @override
  String? get newAccount => _newAccount;

  @override
  int? get discriminator => _discriminator;

  @override
  String? get base => _base;

  @override
  String? get seed => _seed;

  @override
  BigInt? get lamports => _lamports;

  @override
  int? get space => _space;

  @override
  String? get owner => _owner;

  @override
  List<Object?> get props => <Object?>[programId, _source, _newAccount, _discriminator, _base, _seed, _lamports, _space, _owner];
}
