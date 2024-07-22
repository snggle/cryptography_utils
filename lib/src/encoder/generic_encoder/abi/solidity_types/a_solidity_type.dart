import 'package:cryptography_utils/src/encoder/generic_encoder/abi/functions/abi_param_definition.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/a_solidity_array_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_address_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_bool_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_bytes_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_int_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_string_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_tuple_type.dart';

/// Generic Dart representation of the Solidity's type used in the ABI (Application Binary Interface) encoding.
/// https://docs.soliditylang.org/en/latest/abi-spec.html
abstract class ASolidityType {
  /// The size in bytes of the single segment for fixed-size types.
  static const int segmentBytesSize = 32;

  /// The name of the Solidity type.
  final String name;

  /// Creates an instance of the [ASolidityType] with the given [name].
  ASolidityType(this.name);

  /// Returns the specific type for the given [typeName].
  static ASolidityType getType(String typeName, List<AbiParamDefinition>? components) {
    if (typeName.endsWith(']')) {
      return ASolidityArrayType.getType(typeName, components);
    }
    if (typeName.startsWith('int')) {
      return SolidityIntType(typeName);
    }
    if (typeName.startsWith('uint')) {
      return SolidityIntType(typeName);
    }
    if (typeName.startsWith('bytes')) {
      return SolidityBytesType(typeName);
    }
    if (typeName.startsWith('fixed') || typeName.startsWith('ufixed')) {
      throw UnsupportedError('Decimals are not supported yet');
    }
    if ('bool' == typeName) {
      return SolidityBoolType();
    }
    if ('address' == typeName) {
      return SolidityAddressType();
    }
    if ('string' == typeName) {
      return SolidityStringType();
    }
    if ('tuple' == typeName) {
      return SolidityTupleType(components ?? <AbiParamDefinition>[]);
    }
    throw ArgumentError('Unknown type: $typeName');
  }

  /// Returns the canonical name of the Solidity type.
  String get canonicalName => name;

  /// Decodes the given [encoded] list of bytes starting from the given [offset].
  dynamic decode(List<int> encoded, int offset);

  /// Returns the fixed size of the Solidity type.
  int get fixedSize => segmentBytesSize;

  /// Indicates whether the Solidity type has a dynamic size.
  bool get hasDynamicSize => false;

  /// Returns the string representation of the Solidity type.
  @override
  String toString() => canonicalName;
}
