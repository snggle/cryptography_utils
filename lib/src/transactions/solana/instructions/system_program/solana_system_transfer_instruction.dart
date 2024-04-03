import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';

/// An instruction which transfers [lamports] (SOL) from [source] to [destination].
///
/// Example instruction: https://solscan.io/tx/4uyy2M3xF7swQH6ZFbhxfSFLRARqGQMUi65ikzCzcaGWmKR81vubvPcrEQ4yPhaj7MYw3hBow7w9jnFREMDXyfTs?cluster=devnet
/// {
///     info: {
///         destination: "6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z"
///         lamports: 100000000
///         source: "2xGD7cWtwpmCpW2NvT9EJt96eDavS3suVgQNVaBU4A19"
///     }
///     type: "transfer"
/// }
class SolanaSystemTransferInstruction extends ASolanaInstructionDecoded {
  /// Field order on Solscan is based on unknown rules.
  /// Solscan also ignores the [discriminator] for this instruction, even though it is always present in this instruction's data array.
  ///
  /// Our field order below is NOT influenced by Solscan and follows the order of data received from [SolanaCompiledInstruction]:
  /// - account indexes, in order of appearance in the [SolanaCompiledInstruction] accounts field
  /// - instruction data array values, in order of appearance in [SolanaCompiledInstruction] data field
  final String _source;
  final String _destination;
  final int _discriminator;
  final BigInt _lamports;

  const SolanaSystemTransferInstruction({
    required String programId,
    required String source,
    required String destination,
    required int discriminator,
    required BigInt lamports,
  })  : _source = source,
        _destination = destination,
        _discriminator = discriminator,
        _lamports = lamports,
        super(programId: programId);

  /// Creates a new instance of [SolanaSystemTransferInstruction] from the serialized data.
  factory SolanaSystemTransferInstruction.fromSerializedData(
      SolanaCompiledInstruction solanaCompiledInstruction, List<SolanaPubKey> accountKeys, String programId) {
    String source = accountKeys[solanaCompiledInstruction.accounts[0]].toBase58();
    String destination = accountKeys[solanaCompiledInstruction.accounts[1]].toBase58();

    ByteData byteData = solanaCompiledInstruction.data.buffer.asByteData();
    int discriminator = byteData.getUint32(0, Endian.little);
    BigInt lamports = BigInt.from(byteData.getUint64(4, Endian.little));

    return SolanaSystemTransferInstruction(
      programId: programId,
      source: source,
      destination: destination,
      discriminator: discriminator,
      lamports: lamports,
    );
  }

  @override
  String? get source => _source;

  @override
  String? get destination => _destination;

  @override
  int? get discriminator => _discriminator;

  @override
  BigInt? get lamports => _lamports;

  @override
  List<Object?> get props => <Object?>[programId, _source, _destination, _discriminator, _lamports];
}
