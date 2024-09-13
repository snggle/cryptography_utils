import 'dart:typed_data';

import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/a_solidity_type.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_int_type.dart';

/// Dart representation of the Solidity's [bytes] type used in the ABI (Application Binary Interface) encoding.
///
/// Binary type of M bytes (bytes<M>), 0 < M <= 32 or dynamic sized byte sequence (bytes).
/// https://docs.soliditylang.org/en/latest/abi-spec.html
class SolidityBytesType extends ASolidityType {
  SolidityBytesType(super.name);

  /// Decodes the given [encoded] list of bytes starting from the given [offset].
  @override
  dynamic decode(List<int> encoded, int offset) {
    if (hasDynamicSize) {
      int localOffset = offset;
      int length = SolidityIntType.decodeInt(encoded, localOffset).toInt();
      if (length == 0) {
        return Uint8List(0);
      }

      localOffset += ASolidityType.segmentBytesSize;
      return Uint8List.fromList(encoded.sublist(localOffset, localOffset + length));
    } else {
      int length = int.parse(name.replaceAll('bytes', ''));
      return Uint8List.fromList(encoded.sublist(offset, offset + length));
    }
  }

  /// Indicates whether the Solidity type has a dynamic size.
  @override
  bool get hasDynamicSize => name == 'bytes';
}
