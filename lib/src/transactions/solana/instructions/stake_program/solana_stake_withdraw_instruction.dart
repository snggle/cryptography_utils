import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which withdraws unstaked lamports from the [stakeAccount].
class SolanaStakeWithdrawInstruction extends ASolanaInstructionDecoded {
  final String _clockSysvar;
  final String _destination;
  final int _lamports;
  final String _stakeAccount;
  final String _stakeHistorySysvar;
  final String _withdrawAuthority;

  const SolanaStakeWithdrawInstruction({
    required String clockSysvar,
    required String destination,
    required String programId,
    required int lamports,
    required String stakeAccount,
    required String stakeHistorySysvar,
    required String withdrawAuthority,
  })  : _clockSysvar = clockSysvar,
        _destination = destination,
        _lamports = lamports,
        _stakeAccount = stakeAccount,
        _stakeHistorySysvar = stakeHistorySysvar,
        _withdrawAuthority = withdrawAuthority,
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
    int lamports = byteData.getUint64(4, Endian.little);

    return SolanaStakeWithdrawInstruction(
      clockSysvar: clockSysvar,
      destination: destination,
      programId: programId,
      lamports: lamports,
      stakeAccount: stakeAccount,
      stakeHistorySysvar: stakeHistorySysvar,
      withdrawAuthority: withdrawAuthority,
    );
  }

  @override
  String? get clockSysvar => _clockSysvar;

  @override
  String? get destination => _destination;

  @override
  int? get lamports => _lamports;

  @override
  String? get stakeAccount => _stakeAccount;

  @override
  String? get stakeHistorySysvar => _stakeHistorySysvar;

  @override
  String? get withdrawAuthority => _withdrawAuthority;

  @override
  List<Object?> get props => <Object?>[programId, _clockSysvar, _destination, _lamports, _stakeAccount, _stakeHistorySysvar, _withdrawAuthority];
}
