import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/transactions/solana/solana_address_lookup_table.dart';

/// Versioned Transactions are the new transaction format that allow for additional functionality in the Solana runtime,
/// including Address Lookup Tables.
///
/// https://solana.com/developers/guides/advanced/versions
class SolanaV0Message extends ASolanaMessage {
  /// A collection of related addresses
  final List<SolanaAddressLookupTable> addressLookupTableList;

  const SolanaV0Message({
    required super.header,
    required super.accountKeysList,
    required super.recentBlockhash,
    required super.compiledInstructions,
    required this.addressLookupTableList,
  });

  /// Creates a new instance of [SolanaV0Message] from the serialized data.
  factory SolanaV0Message.fromSerializedData(Uint8List data) {
    ByteReader byteReader = ByteReader(data);

    int versionByte = byteReader.shiftRight();
    int version = versionByte & 0x7F;
    if (version != 0) {
      throw Exception('Only version 0 is supported');
    }

    SolanaMessageHeader header = SolanaMessageHeader.fromBytes(byteReader);

    int accountsCount = CompactU16Decoder.decode(byteReader);
    List<SolanaPubKey> accountKeys = List<SolanaPubKey>.generate(accountsCount, (_) {
      Uint8List key = byteReader.shiftRightBy(SolanaPubKey.publicKeyLength);
      return SolanaPubKey(Uint8List.fromList(key));
    });

    Uint8List recentBlockhash = byteReader.shiftRightBy(SolanaPubKey.publicKeyLength);

    int instructionCount = CompactU16Decoder.decode(byteReader);
    List<SolanaCompiledInstruction> instructions = List<SolanaCompiledInstruction>.generate(instructionCount, (_) {
      return SolanaCompiledInstruction.fromSerializedData(byteReader);
    });

    int addressLookupCount = CompactU16Decoder.decode(byteReader);
    List<SolanaAddressLookupTable> addressLookupTables = List<SolanaAddressLookupTable>.generate(addressLookupCount, (_) {
      return SolanaAddressLookupTable.fromSerializedData(byteReader);
    });

    return SolanaV0Message(
      header: header,
      accountKeysList: accountKeys,
      recentBlockhash: recentBlockhash,
      compiledInstructions: instructions,
      addressLookupTableList: addressLookupTables,
    );
  }

  @override
  List<Object?> get props => <Object?>[header, accountKeysList, recentBlockhash, compiledInstructions, addressLookupTableList];
}
