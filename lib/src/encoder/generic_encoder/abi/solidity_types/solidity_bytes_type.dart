import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/a_solidity_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_int_type.dart';

/// Dart representation of the Solidity's [bytes] type used in the ABI (Application Binary Interface) encoding.
///
/// Binary type of M bytes (bytes<M>), 0 < M <= 32 or dynamic sized byte sequence (bytes).
/// https://docs.soliditylang.org/en/latest/abi-spec.html
class SolidityBytesType extends ASolidityType {
  /// The length of the bytes.
  int? length;

  SolidityBytesType([String? name]) : super(name ?? 'bytes');

  /// Decodes the given [encoded] list of bytes starting from the given [offset].
  @override
  dynamic decode(List<int> encoded, int offset) {
    int localOffset = offset;

    length = _getLengthFromName();
    if (length == null) {
      length = SolidityIntType.decodeInt(encoded, offset).toInt();
      localOffset += ASolidityType.segmentBytesSize;
    } else if (length == 0) {
      return Uint8List(0);
    }

    return Uint8List.fromList(encoded.sublist(localOffset, min(localOffset + length!, encoded.length)));
  }

  /// Returns the fixed size of the Solidity type.
  @override
  int get fixedSize {
    if (length == null) {
      throw Exception('Length is not calculated yet');
    }
    return (length! / 32).ceil() * ASolidityType.segmentBytesSize + ASolidityType.segmentBytesSize;
  }

  /// Returns the bytes size from the name if name is a fixed-size bytes type.
  int? _getLengthFromName() {
    if (name.startsWith('bytes') == false) {
      return null;
    }
    String paddedName = name.replaceAll('bytes', '');
    if (paddedName.isNotEmpty) {
      return int.parse(paddedName);
    } else {
      return null;
    }
  }
}
