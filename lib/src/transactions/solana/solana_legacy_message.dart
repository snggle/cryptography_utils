import 'dart:convert';
import 'dart:typed_data';
import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

class SolanaLegacyMessage extends ASolanaMessage {
  @override
  final int numRequiredSignatures;
  @override
  final int numReadonlySignedAccounts;
  @override
  final int numReadonlyUnsignedAccounts;
  @override
  final List<Uint8List> accountKeys;
  @override
  final Uint8List recentBlockhash;
  @override
  final List<SolanaInstruction> instructions;

  SolanaLegacyMessage({
    required this.numRequiredSignatures,
    required this.numReadonlySignedAccounts,
    required this.numReadonlyUnsignedAccounts,
    required this.accountKeys,
    required this.recentBlockhash,
    required this.instructions,
  });

  factory SolanaLegacyMessage.fromBytes(Uint8List data) {
    int publicKeyLength = 32;

    ByteReader reader = ByteReader(data);
    int numRequiredSignatures = reader.shiftRight();
    int numReadonlySignedAccounts = reader.shiftRight();
    int numReadonlyUnsignedAccounts = reader.shiftRight();

    int accountsCount = CompactU16Decoder.decode(reader);

    List<Uint8List> accountKeys = List<Uint8List>.generate(accountsCount, (_) {
      Uint8List key = reader.shiftRightBy(publicKeyLength);
      return Uint8List.fromList(key);
    });

    Uint8List recentBlockhash = reader.shiftRightBy(publicKeyLength);
    int instructionCount = CompactU16Decoder.decode(reader);

    List<SolanaInstruction> instructions = List<SolanaInstruction>.generate(instructionCount, (_) {
      int programIdIndex = reader.shiftRight();
      int accountCount = CompactU16Decoder.decode(reader);
      Uint8List accountIndices = reader.shiftRightBy(accountCount);
      int dataLength = CompactU16Decoder.decode(reader);
      Uint8List instructionData = reader.shiftRightBy(dataLength);

      return SolanaInstruction(
        programIdIndex: programIdIndex,
        accountIndices: accountIndices,
        data: instructionData,
      );
    });

    return SolanaLegacyMessage(
      numRequiredSignatures: numRequiredSignatures,
      numReadonlySignedAccounts: numReadonlySignedAccounts,
      numReadonlyUnsignedAccounts: numReadonlyUnsignedAccounts,
      accountKeys: accountKeys,
      recentBlockhash: recentBlockhash,
      instructions: instructions,
    );
  }

  @override
  String toString() => const JsonEncoder.withIndent('  ').convert(toJson());

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'numRequiredSignatures': numRequiredSignatures,
      'numReadonlySignedAccounts': numReadonlySignedAccounts,
      'numReadonlyUnsignedAccounts': numReadonlyUnsignedAccounts,
      'accountKeys': accountKeys.map(Base58Codec.encode).toList(),
      'recentBlockhash': Base58Codec.encode(recentBlockhash),
      'instructions': instructions.map((SolanaInstruction instr) {
        final SolanaInstructionDecoded decoded = instr.decode(accountKeys);

        return <String, Object>{
          'programIdIndex': instr.programIdIndex,
          'programId': Base58Codec.encode(accountKeys[instr.programIdIndex]),
          'accountIndices': instr.accountIndices,
          'rawDataHex': instr.data.map((int b) => b.toRadixString(16).padLeft(2, '0')).join(' '),
          'decoded': <String, Object?>{
            'type': decoded.type.name,
            'programId': decoded.programId,
            if (decoded.from != null) 'from': decoded.from,
            if (decoded.to != null) 'to': decoded.to,
            if (decoded.signer != null) 'signer': decoded.signer,
            if (decoded.amount != null) 'amount': decoded.amount,
            if (decoded.amountLamports != null) 'amountLamports': decoded.amountLamports,
            if (decoded.decimals != null) 'decimals': decoded.decimals,
            if (decoded.mint != null) 'mint': decoded.mint,
            if (decoded.fee != null) 'fee': decoded.fee,
            if (decoded.heapFrameBytes != null) 'heapFrameBytes': decoded.heapFrameBytes,
          },
        };
      }).toList(),
    };
  }
}
