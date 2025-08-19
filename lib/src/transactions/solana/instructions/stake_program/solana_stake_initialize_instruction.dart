import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which initializes a [stakeAccount].
class SolanaStakeInitializeInstruction extends ASolanaInstructionDecoded {
  final String _stakeAccount;
  final String _rentSysvar;
  final String _staker;
  final String _withdrawer;
  final int _unixTimestamp;
  final int _epoch;
  final String _custodian;

  const SolanaStakeInitializeInstruction({
    required String programId,
    required String stakeAccount,
    required String rentSysvar,
    required String staker,
    required String withdrawer,
    required int unixTimestamp,
    required int epoch,
    required String custodian,
  })  : _stakeAccount = stakeAccount,
        _rentSysvar = rentSysvar,
        _staker = staker,
        _withdrawer = withdrawer,
        _unixTimestamp = unixTimestamp,
        _epoch = epoch,
        _custodian = custodian,
        super(programId: programId);

  /// Creates a new instance of [SolanaStakeInitializeInstruction] from the serialized data.
  factory SolanaStakeInitializeInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String stakeAccount = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String rentSysvar = accountKeys[solanaCompiledInstruction.accounts[1]].toBase58();

    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    String staker = SolanaPubKey.fromBytes(solanaCompiledInstruction.data.sublist(4, 36)).toBase58();
    String withdrawer = SolanaPubKey.fromBytes(solanaCompiledInstruction.data.sublist(36, 68)).toBase58();
    int unixTimestamp = byteData.getInt64(68, Endian.little);
    int epoch = byteData.getUint64(76, Endian.little);
    String custodian = SolanaPubKey.fromBytes(solanaCompiledInstruction.data.sublist(84, 116)).toBase58();

    return SolanaStakeInitializeInstruction(
      programId: programId,
      stakeAccount: stakeAccount,
      rentSysvar: rentSysvar,
      staker: staker,
      withdrawer: withdrawer,
      unixTimestamp: unixTimestamp,
      epoch: epoch,
      custodian: custodian,
    );
  }

  @override
  String? get stakeAccount => _stakeAccount;

  @override
  String? get rentSysvar => _rentSysvar;

  @override
  String? get staker => _staker;

  @override
  String? get withdrawer => _withdrawer;

  @override
  int? get unixTimestamp => _unixTimestamp;

  @override
  int get epoch => _epoch;

  @override
  String? get custodian => _custodian;

  @override
  List<Object?> get props => <Object?>[programId, _stakeAccount, _rentSysvar, _staker, _withdrawer, _unixTimestamp, _epoch, _custodian];
}
