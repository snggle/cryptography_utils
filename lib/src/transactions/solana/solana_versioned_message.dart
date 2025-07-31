import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/transactions/solana/address_lookup_table.dart';

class SolanaV0Message extends ASolanaMessage {
  final List<AddressLookupTable> addressTableLookups;

  SolanaV0Message({
    required super.numRequiredSignatures,
    required super.numReadonlySignedAccounts,
    required super.numReadonlyUnsignedAccounts,
    required super.accountKeysList,
    required super.recentBlockhash,
    required super.solanaInstructionList,
    required this.addressTableLookups,
  });

  @override
  String toString() => const JsonEncoder.withIndent('  ').convert(toJson());

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
      'addressTableLookups': addressTableLookups.map((AddressLookupTable lookup) {
        return <String, Object>{
          'accountKey': Base58Codec.encode(lookup.accountKey),
          'writableIndexes': lookup.writableIndexesList,
          'readonlyIndexes': lookup.readonlyIndexesList,
        };
      }).toList(),
    };
  }

  factory SolanaV0Message.fromSerializedData(Uint8List data) {
    int publicKeyLength = 32;

    ByteReader byteReader = ByteReader(data);

    int versionByte = byteReader.shiftRight();

    int version = versionByte & 0x7F;

    if (version != 0) {
      throw UnsupportedError('Only version 0 is supported');
    }

    int numRequiredSignatures = byteReader.shiftRight();
    int numReadonlySignedAccounts = byteReader.shiftRight();
    int numReadonlyUnsignedAccounts = byteReader.shiftRight();

    int accountsCount = CompactU16Decoder.decode(byteReader);

    List<Uint8List> accountKeys = List<Uint8List>.generate(accountsCount, (_) {
      Uint8List key = byteReader.shiftRightBy(publicKeyLength);
      return Uint8List.fromList(key);
    });

    Uint8List recentBlockhash = byteReader.shiftRightBy(publicKeyLength);
    int instructionCount = CompactU16Decoder.decode(byteReader);

    List<SolanaInstruction> instructions = List<SolanaInstruction>.generate(instructionCount, (_) {
      int programIdIndex = byteReader.shiftRight();
      int accountCount = CompactU16Decoder.decode(byteReader);

      Uint8List accountIndices = Uint8List.fromList(
        List<int>.generate(accountCount, (_) => CompactU16Decoder.decode(byteReader)),
      );

      int dataLength = CompactU16Decoder.decode(byteReader);

      Uint8List instructionData = byteReader.shiftRightBy(dataLength);

      return SolanaInstruction(
        programIdIndex: programIdIndex,
        accountIndices: accountIndices,
        data: instructionData,
      );
    });

    int addressLookupCount = CompactU16Decoder.decode(byteReader);

    List<AddressLookupTable> addressLookupTables = List<AddressLookupTable>.generate(addressLookupCount, (_) {
      Uint8List accountKey = byteReader.shiftRightBy(publicKeyLength);

      int writableCount = CompactU16Decoder.decode(byteReader);

      List<int> writableIndexes = List<int>.generate(writableCount, (_) {
        int index = byteReader.shiftRight();
        return index;
      });

      int readonlyCount = CompactU16Decoder.decode(byteReader);

      List<int> readonlyIndexes = List<int>.generate(readonlyCount, (_) {
        int index = byteReader.shiftRight();
        return index;
      });

      return AddressLookupTable(
        accountKey: accountKey,
        writableIndexesList: writableIndexes,
        readonlyIndexesList: readonlyIndexes,
      );
    });

    return SolanaV0Message(
      numRequiredSignatures: numRequiredSignatures,
      numReadonlySignedAccounts: numReadonlySignedAccounts,
      numReadonlyUnsignedAccounts: numReadonlyUnsignedAccounts,
      accountKeysList: accountKeys,
      recentBlockhash: recentBlockhash,
      solanaInstructionList: instructions,
      addressTableLookups: addressLookupTables,
    );
  }
}
