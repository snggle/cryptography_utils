import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which withdraws unstaked lamports from the [stakeAccount].
///
/// Example instruction: https://solscan.io/tx/3an1bBo4bpPiKJPTohfMB2TRdGUVTzoT8vpZ1RfHjnaQWH7CRguKogqqfaerYoYTJ7zGi2bhibzpNs8VB274uYLD?cluster=devnet
/// {
///   "info": {
///     "clockSysvar": "SysvarC1ock11111111111111111111111111111111",
///     "destination": "2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19",
///     "lamports": 12282880,
///     "stakeAccount": "CkT3NP8HMam7v73564b638kPBvy8SGTt9mNjuLtRw79k",
///     "stakeHistorySysvar": "SysvarStakeHistory1111111111111111111111111",
///     "withdrawAuthority": "2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19"
///   },
///   "type": "withdraw"
/// }
class SolanaStakeWithdrawInstruction extends ASolanaInstructionDecoded {
  /// Field order on Solscan is based on unknown rules.
  /// Solscan also ignores the [discriminator] for this instruction, even though it is always present in this instruction's data array.
  ///
  /// Our field order below is NOT influenced by Solscan and follows the order of data received from [SolanaCompiledInstruction]:
  /// - account indexes, in order of appearance in the [SolanaCompiledInstruction] accounts field
  /// - instruction data array values, in order of appearance in [SolanaCompiledInstruction] data field
  final String _stakeAccount;
  final String _destination;
  final String _clockSysvar;
  final String _stakeHistorySysvar;
  final String _withdrawAuthority;
  final int _discriminator;
  final BigInt _lamports;

  const SolanaStakeWithdrawInstruction({
    required String programId,
    required String stakeAccount,
    required String destination,
    required String clockSysvar,
    required String stakeHistorySysvar,
    required String withdrawAuthority,
    required int discriminator,
    required BigInt lamports,
  })  : _stakeAccount = stakeAccount,
        _destination = destination,
        _clockSysvar = clockSysvar,
        _stakeHistorySysvar = stakeHistorySysvar,
        _withdrawAuthority = withdrawAuthority,
        _discriminator = discriminator,
        _lamports = lamports,
        super(programId: programId);

  /// Creates a new instance of [SolanaStakeWithdrawInstruction] from the serialized data.
  factory SolanaStakeWithdrawInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String stakeAccount = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String destination = accountKeys[solanaCompiledInstruction.accounts[1]].toBase58();
    String clockSysvar = accountKeys[solanaCompiledInstruction.accounts[2]].toBase58();
    String stakeHistorySysvar = accountKeys[solanaCompiledInstruction.accounts[3]].toBase58();
    String withdrawAuthority = accountKeys[solanaCompiledInstruction.accounts[4]].toBase58();

    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    int discriminator = byteData.getUint32(0, Endian.little);
    BigInt lamports = BigInt.from(byteData.getUint64(4, Endian.little));

    return SolanaStakeWithdrawInstruction(
      programId: programId,
      stakeAccount: stakeAccount,
      destination: destination,
      clockSysvar: clockSysvar,
      stakeHistorySysvar: stakeHistorySysvar,
      withdrawAuthority: withdrawAuthority,
      discriminator: discriminator,
      lamports: lamports,
    );
  }

  @override
  String? get stakeAccount => _stakeAccount;

  @override
  String? get destination => _destination;

  @override
  String? get clockSysvar => _clockSysvar;

  @override
  String? get stakeHistorySysvar => _stakeHistorySysvar;

  @override
  String? get withdrawAuthority => _withdrawAuthority;

  @override
  int? get discriminator => _discriminator;

  @override
  BigInt? get lamports => _lamports;

  @override
  List<Object?> get props => <Object?>[
        programId,
        _stakeAccount,
        _destination,
        _clockSysvar,
        _stakeHistorySysvar,
        _withdrawAuthority,
        _discriminator,
        _lamports,
      ];
}
