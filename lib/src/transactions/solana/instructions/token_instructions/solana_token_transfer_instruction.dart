import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// Approve a delegate to transfer up to a maximum number of tokens from an account, asserting the token mint and decimals
///
/// https://solana-labs.github.io/solana-program-library/token/js/functions/approveChecked.html
class SolanaTokenTransferInstruction extends ASolanaInstructionDecoded {
  final int _amount;
  final String _mint;
  final String _delegate;
  final String _source;
  final String _owner;
  final int _decimals;

  const SolanaTokenTransferInstruction({
    required String programId,
    required int amount,
    required String mint,
    required String delegate,
    required String source,
    required String owner,
    required int decimals,
  })  : _amount = amount,
        _mint = mint,
        _delegate = delegate,
        _source = source,
        _owner = owner,
        _decimals = decimals,
        super(programId: programId);

  /// Creates a new instance of [SolanaTokenTransferInstruction] from the serialized data.
  static SolanaTokenTransferInstruction fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    int amount = byteData.getUint64(1, Endian.little);
    int decimals = byteData.getUint8(9);
    String source = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String mint = accountKeys[solanaCompiledInstruction.accounts[1]].toBase58();
    String delegate = accountKeys[solanaCompiledInstruction.accounts[2]].toBase58();
    String owner = accountKeys[solanaCompiledInstruction.accounts[3]].toBase58();
    return SolanaTokenTransferInstruction(
      programId: programId,
      source: source,
      delegate: delegate,
      owner: owner,
      mint: mint,
      amount: amount,
      decimals: decimals,
    );
  }

  @override
  int? get amount {
    return _amount;
  }

  @override
  String? get mint {
    return _mint;
  }

  @override
  String? get recipient {
    return _delegate;
  }

  @override
  String? get sender {
    return _source;
  }

  @override
  String? get signer {
    return _owner;
  }

  @override
  int? get tokenDecimalPrecision {
    return _decimals;
  }

  @override
  List<Object?> get props => <Object?>[programId, amount, tokenDecimalPrecision, recipient, sender, signer, mint];
}
