import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which withdraws unstaked lamports from the [stakeAccount].
class SolanaStakeWithdrawInstruction extends ASolanaInstructionDecoded {
  final int _lamports;
  final String _stakeAccount;
  final String _withdrawAuthority;

  const SolanaStakeWithdrawInstruction({
    required String programId,
    required int lamports,
    required String withdrawAuthority,
    required String stakeAccount,
  })  : _lamports = lamports,
        _withdrawAuthority = withdrawAuthority,
        _stakeAccount = stakeAccount,
        super(programId: programId);

  /// Creates a new instance of [SolanaStakeWithdrawInstruction] from the serialized data.
  factory SolanaStakeWithdrawInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    int lamports = byteData.getUint64(4, Endian.little);
    String stakeAccount = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String withdrawAuthority = accountKeys[solanaCompiledInstruction.accounts[4]].toBase58();
    return SolanaStakeWithdrawInstruction(
      programId: programId,
      lamports: lamports,
      withdrawAuthority: withdrawAuthority,
      stakeAccount: stakeAccount,
    );
  }

  @override
  int? get lamports => _lamports;

  @override
  String? get withdrawAuthority => _withdrawAuthority;

  @override
  String? get stakeAccount => _stakeAccount;

  @override
  List<Object?> get props => <Object?>[programId, lamports, withdrawAuthority, stakeAccount];
}
