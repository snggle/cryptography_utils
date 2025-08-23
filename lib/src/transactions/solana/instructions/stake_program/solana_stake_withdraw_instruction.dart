import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which withdraws unstaked lamports from the [stakeAccount].
class SolanaStakeWithdrawInstruction extends ASolanaInstructionDecoded {
  final String _stakeAccount;
  final String _destination;
  final String _clockSysvar;
  final String _stakeHistorySysvar;
  final String _withdrawAuthority;
  final BigInt _lamports;

  const SolanaStakeWithdrawInstruction({
    required String programId,
    required String stakeAccount,
    required String destination,
    required String clockSysvar,
    required String stakeHistorySysvar,
    required String withdrawAuthority,
    required BigInt lamports,
  })  : _stakeAccount = stakeAccount,
        _destination = destination,
        _clockSysvar = clockSysvar,
        _stakeHistorySysvar = stakeHistorySysvar,
        _withdrawAuthority = withdrawAuthority,
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
    BigInt lamports = BigInt.from(byteData.getUint64(4, Endian.little));

    return SolanaStakeWithdrawInstruction(
      programId: programId,
      stakeAccount: stakeAccount,
      destination: destination,
      clockSysvar: clockSysvar,
      stakeHistorySysvar: stakeHistorySysvar,
      withdrawAuthority: withdrawAuthority,
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
  BigInt? get lamports => _lamports;

  @override
  List<Object?> get props => <Object?>[programId, _stakeAccount, _destination, _clockSysvar, _stakeHistorySysvar, _withdrawAuthority, _lamports];
}
