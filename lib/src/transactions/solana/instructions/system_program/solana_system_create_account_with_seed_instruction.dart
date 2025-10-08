import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

// TODO(Kamil): desc
/// An instruction which creates [newAccount] with [seed], belonging to [source],
/// paying [lamports] (SOL) which includes the staked amount as well as a fee for account creation.
///
/// Example instruction: https://solscan.io/tx/4uyy2M3xF7swQH6ZFbhxfSFLRARqGQMUi65ikzCzcaGWmKR81vubvPcrEQ4yPhaj7MYw3hBow7w9jnFREMDXyfTs?cluster=devnet
/// {
///     info: {
///         base: "2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19"
///         lamports: 12282880
///         newAccount: "CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k"
///         owner: "Stake11111111111111111111111111111111111111"
///         seed: "stake:0"
///         source: "2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19"
///         space: 200
///     }
///     type: "createAccountWithSeed"
/// }
class SolanaSystemCreateAccountWithSeedInstruction extends ASolanaInstructionDecoded {
  final String _source;
  final String _newAccount;
  final String _base;
  final String _seed;
  final BigInt _lamports;
  final int _space;
  final String _owner;

  const SolanaSystemCreateAccountWithSeedInstruction({
    required String programId,
    required String source,
    required String newAccount,
    required String base,
    required String seed,
    required BigInt lamports,
    required int space,
    required String owner,
  })  : _source = source,
        _newAccount = newAccount,
        _base = base,
        _seed = seed,
        _lamports = lamports,
        _space = space,
        _owner = owner,
        super(programId: programId);

  /// Creates a new instance of [SolanaSystemTransferInstruction] from the serialized data.
  factory SolanaSystemCreateAccountWithSeedInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String source = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String newAccount = accountKeys[solanaCompiledInstruction.accounts[1]].toBase58();

    ByteReader reader = ByteReader(solanaCompiledInstruction.data)..shiftRightBy(4);

    Uint8List baseBytes = reader.shiftRightBy(32);
    String base = SolanaPubKey(baseBytes).toBase58();

    Uint8List seedLengthBytes = reader.shiftRightBy(8);
    int seedLength = ByteData.sublistView(seedLengthBytes).getUint32(0, Endian.little);
    Uint8List seedBytes = reader.shiftRightBy(seedLength);
    String seed = utf8.decode(seedBytes);

    Uint8List lamportsBytes = reader.shiftRightBy(8);
    int lamportsInt = ByteData.sublistView(lamportsBytes).getUint64(0, Endian.little);
    BigInt lamports = BigInt.from(lamportsInt);

    Uint8List spaceBytes = reader.shiftRightBy(8);
    int space = ByteData.sublistView(spaceBytes).getUint64(0, Endian.little);

    Uint8List ownerBytes = reader.shiftRightBy(32);
    String owner = SolanaPubKey(ownerBytes).toBase58();

    return SolanaSystemCreateAccountWithSeedInstruction(
      programId: programId,
      source: source,
      newAccount: newAccount,
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
  List<Object?> get props => <Object?>[programId, _source, _newAccount, _base, _seed, _lamports, _space, _owner];
}
