import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/transactions/solana/a_solana_message.dart';
import 'package:cryptography_utils/src/transactions/solana/address_lookup_table.dart';

class SolanaV0Message extends ASolanaMessage {
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
  final List<AddressLookupTable> addressTableLookups;

  SolanaV0Message({
    required this.numRequiredSignatures,
    required this.numReadonlySignedAccounts,
    required this.numReadonlyUnsignedAccounts,
    required this.accountKeys,
    required this.recentBlockhash,
    required this.instructions,
    required this.addressTableLookups,
  });

  factory SolanaV0Message.fromBytes(Uint8List data) {
    ByteReader reader = ByteReader(data);
    int versionByte = reader.readByte();
    int version = versionByte & 0x7F;
    if (version != 0) {
      throw UnsupportedError('Only version 0 is supported');
    }

    int numRequiredSignatures = reader.readByte();
    int numReadonlySignedAccounts = reader.readByte();
    int numReadonlyUnsignedAccounts = reader.readByte();

    int accCount = reader.decodeCompactU16().value;
    List<Uint8List> accountKeys = List<Uint8List>.generate(accCount, (_) => reader.readBytes(32));

    Uint8List recentBlockhash = reader.readBytes(32);

    int instrucCount = reader.decodeCompactU16().value;
    List<SolanaInstruction> instructions = List<SolanaInstruction>.generate(instrucCount, (_) {
      int programIdIndex = reader.readByte();
      int accountCount = reader.decodeCompactU16().value;
      List<int> accountIndices = List<int>.generate(accountCount, (_) => reader.readByte());
      int dataLength = reader.decodeCompactU16().value;
      Uint8List instructionData = reader.readBytes(dataLength);

      return SolanaInstruction(
        programIdIndex: programIdIndex,
        accountIndices: accountIndices,
        data: instructionData,
      );
    });

    int addressLookupCount = reader.decodeCompactU16().value;
    List<AddressLookupTable> addressLookupTables = List<AddressLookupTable>.generate(addressLookupCount, (_) {
      Uint8List accountKey = reader.readBytes(32);
      int writableCount = reader.decodeCompactU16().value;
      List<int> writableIndexes = List<int>.generate(writableCount, (_) => reader.readByte());
      int readonlyCount = reader.decodeCompactU16().value;
      List<int> readonlyIndexes = List<int>.generate(readonlyCount, (_) => reader.readByte());
      print('Suchar: Creating AddressTableLookup');
      return AddressLookupTable(
        accountKey: accountKey,
        writableIndexes: writableIndexes,
        readonlyIndexes: readonlyIndexes,
      );
    });

    return SolanaV0Message(
      numRequiredSignatures: numRequiredSignatures,
      numReadonlySignedAccounts: numReadonlySignedAccounts,
      numReadonlyUnsignedAccounts: numReadonlyUnsignedAccounts,
      accountKeys: accountKeys,
      recentBlockhash: recentBlockhash,
      instructions: instructions,
      addressTableLookups: addressLookupTables,
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
        SolanaInstructionDecoded decoded = instr.decode(accountKeys);
        return <String, dynamic>{
          'programIdIndex': instr.programIdIndex,
          'programId': Base58Codec.encode(accountKeys[instr.programIdIndex]),
          'accountIndices': instr.accountIndices,
          'rawDataHex': instr.data.map((int b) => b.toRadixString(16).padLeft(2, '0')).join(' '),
          'decoded': <String, dynamic>{
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
      'addressTableLookups': addressTableLookups.map((AddressLookupTable lookup) {
        return <String, Object>{
          'accountKey': Base58Codec.encode(lookup.accountKey),
          'writableIndexes': lookup.writableIndexes,
          'readonlyIndexes': lookup.readonlyIndexes,
        };
      }).toList(),
    };
  }
}