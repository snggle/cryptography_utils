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
    int offset = 0;
    int length;

    length = CompactU16Decoder.decodeLength(data, offset);
    int numRequiredSignatures = CompactU16Decoder.decodeValue(data, offset, length);
    offset += length;

    length = CompactU16Decoder.decodeLength(data, offset);
    int numReadonlySignedAccounts = CompactU16Decoder.decodeValue(data, offset, length);
    offset += length;

    length = CompactU16Decoder.decodeLength(data, offset);
    int numReadonlyUnsignedAccounts = CompactU16Decoder.decodeValue(data, offset, length);
    offset += length;

    length = CompactU16Decoder.decodeLength(data, offset);
    int accCount = CompactU16Decoder.decodeValue(data, offset, length);
    offset += length;

    List<Uint8List> accountKeys = List<Uint8List>.generate(accCount, (_) {
      Uint8List key = data.sublist(offset, offset + 32);
      offset += 32;
      return Uint8List.fromList(key);
    });

    Uint8List recentBlockhash = Uint8List.fromList(data.sublist(offset, offset + 32));
    offset += 32;

    length = CompactU16Decoder.decodeLength(data, offset);
    int instrucCount = CompactU16Decoder.decodeValue(data, offset, length);
    offset += length;

    List<SolanaInstruction> instructions = List<SolanaInstruction>.generate(instrucCount, (_) {
      length = CompactU16Decoder.decodeLength(data, offset);
      int programIdIndex = CompactU16Decoder.decodeValue(data, offset, length);
      offset += length;

      length = CompactU16Decoder.decodeLength(data, offset);
      int accountCount = CompactU16Decoder.decodeValue(data, offset, length);
      offset += length;

      List<int> accountIndices = List<int>.generate(accountCount, (_) {
        length = CompactU16Decoder.decodeLength(data, offset);
        int index = CompactU16Decoder.decodeValue(data, offset, length);
        offset += length;
        return index;
      });

      length = CompactU16Decoder.decodeLength(data, offset);
      int dataLength = CompactU16Decoder.decodeValue(data, offset, length);
      offset += length;

      Uint8List instructionData = Uint8List.fromList(data.sublist(offset, offset + dataLength));
      offset += dataLength;

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
