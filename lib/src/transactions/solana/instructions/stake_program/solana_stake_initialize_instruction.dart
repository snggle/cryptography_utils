import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which initializes a [stakeAccount].
class SolanaStakeInitializeInstruction extends ASolanaInstructionDecoded {
  final String _custodian;
  final int _epoch;
  final String _rentSysvar;
  final String _stakeAccount;
  final String _staker;
  final int _unixTimestamp;
  final String _withdrawer;

  const SolanaStakeInitializeInstruction({
    required String custodian,
    required int epoch,
    required String programId,
    required String rentSysvar,
    required String stakeAccount,
    required String staker,
    required int unixTimestamp,
    required String withdrawer,
  })  : _custodian = custodian,
        _epoch = epoch,
        _rentSysvar = rentSysvar,
        _stakeAccount = stakeAccount,
        _staker = staker,
        _unixTimestamp = unixTimestamp,
        _withdrawer = withdrawer,
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
      custodian: custodian,
      epoch: epoch,
      programId: programId,
      rentSysvar: rentSysvar,
      stakeAccount: stakeAccount,
      staker: staker,
      unixTimestamp: unixTimestamp,
      withdrawer: withdrawer,
    );
  }

  @override
  String? get custodian => _custodian;

  @override
  int get epoch => _epoch;

  @override
  String? get rentSysvar => _rentSysvar;

  @override
  String? get stakeAccount => _stakeAccount;

  @override
  String? get staker => _staker;

  @override
  int? get unixTimestamp => _unixTimestamp;

  @override
  String? get withdrawer => _withdrawer;

  @override
  List<Object?> get props => <Object?>[programId, _custodian, _epoch, _rentSysvar, _stakeAccount, _staker, _unixTimestamp, _withdrawer];
}
