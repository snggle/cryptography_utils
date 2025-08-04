import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/transactions/solana/address_lookup_table.dart';

class SolanaV0Message extends ASolanaMessage {
  final List<AddressLookupTable> addressTableLookups;

  const SolanaV0Message({
    required super.header,
    required super.accountKeysList,
    required super.recentBlockhash,
    required super.solanaInstructionList,
    required this.addressTableLookups,
  });

  factory SolanaV0Message.fromSerializedData(Uint8List data) {
    int publicKeyLength = 32;

    ByteReader byteReader = ByteReader(data);

    int versionByte = byteReader.shiftRight();

    int version = versionByte & 0x7F;

    if (version != 0) {
      throw Exception('Only version 0 is supported');
    }

    SolanaMessageHeader header = SolanaMessageHeader.fromBytes(byteReader);

    int accountsCount = CompactU16Decoder.decode(byteReader);

    List<Uint8List> accountKeys = List<Uint8List>.generate(accountsCount, (_) {
      Uint8List key = byteReader.shiftRightBy(publicKeyLength);
      return Uint8List.fromList(key);
    });

    Uint8List recentBlockhash = byteReader.shiftRightBy(publicKeyLength);
    int instructionCount = CompactU16Decoder.decode(byteReader);

    List<SolanaInstructionRaw> instructions = List<SolanaInstructionRaw>.generate(instructionCount, (_) {
      return SolanaInstructionRaw.fromSerializedData(byteReader);
    });

    int addressLookupCount = CompactU16Decoder.decode(byteReader);

    List<AddressLookupTable> addressLookupTables = List<AddressLookupTable>.generate(addressLookupCount, (_) {
      return AddressLookupTable.fromSerializedData(byteReader);
    });

    return SolanaV0Message(
      header: header,
      accountKeysList: accountKeys,
      recentBlockhash: recentBlockhash,
      solanaInstructionList: instructions,
      addressTableLookups: addressLookupTables,
    );
  }

  @override
  List<Object?> get props => <Object?>[header, accountKeysList, recentBlockhash, solanaInstructionList, addressTableLookups];
}
