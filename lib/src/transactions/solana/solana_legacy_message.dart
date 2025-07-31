import 'dart:convert';
import 'dart:typed_data';
import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

class SolanaLegacyMessage extends ASolanaMessage {

  SolanaLegacyMessage({
    required super.numRequiredSignatures,
    required super.numReadonlySignedAccounts,
    required super.numReadonlyUnsignedAccounts,
    required super.accountKeysList,
    required super.recentBlockhash,
    required super.solanaInstructionList,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'numRequiredSignatures': numRequiredSignatures,
      'numReadonlySignedAccounts': numReadonlySignedAccounts,
      'numReadonlyUnsignedAccounts': numReadonlyUnsignedAccounts,
      'accountKeys': accountKeysList.map(Base58Codec.encode).toList(),
      'recentBlockhash': Base58Codec.encode(recentBlockhash),
      'instructions': solanaInstructionList.map((SolanaInstruction solanaInstruction) {
        SolanaInstructionDecoded solanaInstructionDecoded = solanaInstruction.decode(accountKeysList);

        return <String, dynamic>{
          'programIdIndex': solanaInstruction.programIdIndex,
          'programId': Base58Codec.encode(accountKeysList[solanaInstruction.programIdIndex]),
          'accountIndices': solanaInstruction.accountIndices,
          'rawDataHex': solanaInstruction.data.map((int b) => b.toRadixString(16).padLeft(2, '0')).join(' '),
          'decoded': <String, dynamic>{
            'type': solanaInstructionDecoded.type.name,
            'programId': solanaInstructionDecoded.programId,
            if (solanaInstructionDecoded.from != null) 'from': solanaInstructionDecoded.from,
            if (solanaInstructionDecoded.to != null) 'to': solanaInstructionDecoded.to,
            if (solanaInstructionDecoded.signer != null) 'signer': solanaInstructionDecoded.signer,
            if (solanaInstructionDecoded.amount != null) 'amount': solanaInstructionDecoded.amount,
            if (solanaInstructionDecoded.amountSwappedTo != null) 'amountSwappedTo': solanaInstructionDecoded.amountSwappedTo,
            if (solanaInstructionDecoded.tokenDecimalPrecision != null) 'decimals': solanaInstructionDecoded.tokenDecimalPrecision,
            if (solanaInstructionDecoded.mint != null) 'mint': solanaInstructionDecoded.mint,
            if (solanaInstructionDecoded.unitPrice != null) 'unitPrice': solanaInstructionDecoded.unitPrice,
            if (solanaInstructionDecoded.unitLimit != null) 'unitLimit': solanaInstructionDecoded.unitLimit,
          },
        };
      }).toList(),
    };
  }

  @override
  String toString() => const JsonEncoder.withIndent('  ').convert(toJson());

  factory SolanaLegacyMessage.fromSerializedData(Uint8List data) {
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
      accountKeysList: accountKeys,
      recentBlockhash: recentBlockhash,
      solanaInstructionList: instructions,
    );
  }
}
