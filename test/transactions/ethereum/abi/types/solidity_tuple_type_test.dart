import 'package:codec_utils/src/codecs/hex/hex_codec.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/functions/abi_param_definition.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_address_type.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_bool_type.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_bytes_type.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_dynamic_array_type.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_int_type.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_static_array_type.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_string_type.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_tuple_type.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Tests of SolidityTupleType.canonicalName getter', () {
    test('Should [return canonical name] for SolidityTupleType', () {
      // Arrange
      SolidityTupleType actualSolidityTupleType = SolidityTupleType(
        <AbiParamDefinition>[
          AbiParamDefinition(name: 'address', type: SolidityAddressType()),
          AbiParamDefinition(name: 'bool', type: SolidityBoolType()),
          AbiParamDefinition(name: 'bytes', type: SolidityBytesType('bytes')),
          AbiParamDefinition(name: 'dynamic_array', type: SolidityDynamicArrayType('int256[]')),
          AbiParamDefinition(name: 'nested_dynamic_array', type: SolidityDynamicArrayType('int256[][]')),
          AbiParamDefinition(name: 'int', type: SolidityIntType('int256')),
          AbiParamDefinition(name: 'uint', type: SolidityIntType('uint256')),
          AbiParamDefinition(name: 'static_array', type: SolidityStaticArrayType('int256[10]')),
          AbiParamDefinition(name: 'nested_static_array', type: SolidityStaticArrayType('int256[3][3]')),
          AbiParamDefinition(name: 'string', type: SolidityStringType()),
          AbiParamDefinition(
            name: 'nested_tuple',
            type: SolidityTupleType(<AbiParamDefinition>[
              AbiParamDefinition(name: 'address', type: SolidityAddressType()),
              AbiParamDefinition(name: 'bool', type: SolidityBoolType()),
              AbiParamDefinition(name: 'bytes', type: SolidityBytesType('bytes')),
              AbiParamDefinition(name: 'dynamic_array', type: SolidityDynamicArrayType('int256[]')),
              AbiParamDefinition(name: 'nested_dynamic_array', type: SolidityDynamicArrayType('int256[][]')),
              AbiParamDefinition(name: 'int', type: SolidityIntType('int256')),
              AbiParamDefinition(name: 'uint', type: SolidityIntType('uint256')),
              AbiParamDefinition(name: 'static_array', type: SolidityStaticArrayType('int256[10]')),
              AbiParamDefinition(name: 'nested_static_array', type: SolidityStaticArrayType('int256[3][3]')),
              AbiParamDefinition(name: 'string', type: SolidityStringType()),
            ]),
          )
        ],
      );

      // Act
      String actualCanonicalName = actualSolidityTupleType.canonicalName;

      // Assert
      String expectedCanonicalName =
          '(address,bool,bytes,int256[],int256[][],int256,uint256,int256[10],int256[3][3],string,(address,bool,bytes,int256[],int256[][],int256,uint256,int256[10],int256[3][3],string))';

      expect(actualCanonicalName, expectedCanonicalName);
    });
  });

  group('Tests of SolidityTupleType.decode()', () {
    test('Should [return Tuple] decoded from given bytes for Tuple [containing DYNAMIC types]', () {
      // Arrange
      SolidityTupleType actualSolidityTupleType = SolidityTupleType(
        <AbiParamDefinition>[
          AbiParamDefinition(name: 'address', type: SolidityAddressType()),
          AbiParamDefinition(name: 'bool', type: SolidityBoolType()),
          AbiParamDefinition(name: 'bytes', type: SolidityBytesType('bytes')),
          AbiParamDefinition(name: 'dynamic_array', type: SolidityDynamicArrayType('int256[]')),
          AbiParamDefinition(name: 'nested_dynamic_array', type: SolidityDynamicArrayType('int256[][]')),
          AbiParamDefinition(name: 'int', type: SolidityIntType('int256')),
          AbiParamDefinition(name: 'uint', type: SolidityIntType('uint256')),
          AbiParamDefinition(name: 'static_array', type: SolidityStaticArrayType('int256[10]')),
          AbiParamDefinition(name: 'nested_static_array', type: SolidityStaticArrayType('int256[3][3]')),
          AbiParamDefinition(name: 'string', type: SolidityStringType()),
          AbiParamDefinition(
            name: 'nested_tuple',
            type: SolidityTupleType(<AbiParamDefinition>[
              AbiParamDefinition(name: 'address', type: SolidityAddressType()),
            ]),
          )
        ],
      );

      List<int> actualBytes = HexCodec.decode(
        '0x'
        '00000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c'
        '0000000000000000000000000000000000000000000000000000000000000001'
        '0000000000000000000000000000000000000000000000000000000000000380'
        '00000000000000000000000000000000000000000000000000000000000003c0'
        '0000000000000000000000000000000000000000000000000000000000000500'
        '00000000000000000000000000000000000000000000000000000000000004d2'
        '00000000000000000000000000000000000000000000000000000000000010e1'
        '0000000000000000000000000000000000000000000000000000000000000001'
        '0000000000000000000000000000000000000000000000000000000000000002'
        '0000000000000000000000000000000000000000000000000000000000000003'
        '0000000000000000000000000000000000000000000000000000000000000004'
        '0000000000000000000000000000000000000000000000000000000000000005'
        '0000000000000000000000000000000000000000000000000000000000000006'
        '0000000000000000000000000000000000000000000000000000000000000007'
        '0000000000000000000000000000000000000000000000000000000000000008'
        '0000000000000000000000000000000000000000000000000000000000000009'
        '000000000000000000000000000000000000000000000000000000000000000a'
        '0000000000000000000000000000000000000000000000000000000000000001'
        '0000000000000000000000000000000000000000000000000000000000000002'
        '0000000000000000000000000000000000000000000000000000000000000003'
        '0000000000000000000000000000000000000000000000000000000000000004'
        '0000000000000000000000000000000000000000000000000000000000000005'
        '0000000000000000000000000000000000000000000000000000000000000006'
        '0000000000000000000000000000000000000000000000000000000000000007'
        '0000000000000000000000000000000000000000000000000000000000000008'
        '0000000000000000000000000000000000000000000000000000000000000009'
        '0000000000000000000000000000000000000000000000000000000000000700'
        '00000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c'
        '0000000000000000000000000000000000000000000000000000000000000004'
        'c0a8000100000000000000000000000000000000000000000000000000000000'
        '0000000000000000000000000000000000000000000000000000000000000009'
        '0000000000000000000000000000000000000000000000000000000000000001'
        '0000000000000000000000000000000000000000000000000000000000000002'
        '0000000000000000000000000000000000000000000000000000000000000003'
        '0000000000000000000000000000000000000000000000000000000000000004'
        '0000000000000000000000000000000000000000000000000000000000000005'
        '0000000000000000000000000000000000000000000000000000000000000006'
        '0000000000000000000000000000000000000000000000000000000000000007'
        '0000000000000000000000000000000000000000000000000000000000000008'
        '0000000000000000000000000000000000000000000000000000000000000009'
        '0000000000000000000000000000000000000000000000000000000000000003'
        '0000000000000000000000000000000000000000000000000000000000000060'
        '00000000000000000000000000000000000000000000000000000000000000e0'
        '0000000000000000000000000000000000000000000000000000000000000160'
        '0000000000000000000000000000000000000000000000000000000000000003'
        '0000000000000000000000000000000000000000000000000000000000000001'
        '0000000000000000000000000000000000000000000000000000000000000002'
        '0000000000000000000000000000000000000000000000000000000000000003'
        '0000000000000000000000000000000000000000000000000000000000000003'
        '0000000000000000000000000000000000000000000000000000000000000004'
        '0000000000000000000000000000000000000000000000000000000000000005'
        '0000000000000000000000000000000000000000000000000000000000000006'
        '0000000000000000000000000000000000000000000000000000000000000003'
        '0000000000000000000000000000000000000000000000000000000000000007'
        '0000000000000000000000000000000000000000000000000000000000000008'
        '0000000000000000000000000000000000000000000000000000000000000009'
        '000000000000000000000000000000000000000000000000000000000000000d'
        '48656c6c6f2c20576f726c642100000000000000000000000000000000000000',
      );

      // Act
      Object actualTuple = actualSolidityTupleType.decode(actualBytes, 0);

      // Assert
      Map<String, dynamic> expectedTuple = <String, dynamic>{
        'address': '0x53bf0a18754873a8102625d8225af6a15a43423c',
        'bool': true,
        'bytes': <int>[192, 168, 0, 1],
        'dynamic_array': <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'],
        'nested_dynamic_array': <List<String>>[
          <String>['1', '2', '3'],
          <String>['4', '5', '6'],
          <String>['7', '8', '9']
        ],
        'int': '1234',
        'uint': '4321',
        'static_array': <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
        'nested_static_array': <List<String>>[
          <String>['1', '2', '3'],
          <String>['4', '5', '6'],
          <String>['7', '8', '9']
        ],
        'string': 'Hello, World!',
        'nested_tuple': <String, String>{'address': '0x53bf0a18754873a8102625d8225af6a15a43423c'}
      };

      expect(actualTuple, expectedTuple);
    });

    test('Should [return Tuple] decoded from given bytes for Tuple [containing STATIC types only]', () {
      // Arrange
      SolidityTupleType actualSolidityTupleType = SolidityTupleType(
        <AbiParamDefinition>[
          AbiParamDefinition(name: 'address', type: SolidityAddressType()),
          AbiParamDefinition(name: 'bool', type: SolidityBoolType()),
          AbiParamDefinition(name: 'int', type: SolidityIntType('int256')),
          AbiParamDefinition(name: 'uint', type: SolidityIntType('uint256')),
          AbiParamDefinition(name: 'static_array', type: SolidityStaticArrayType('int256[10]')),
          AbiParamDefinition(name: 'nested_static_array', type: SolidityStaticArrayType('int256[3][3]')),
          AbiParamDefinition(
            name: 'nested_tuple',
            type: SolidityTupleType(<AbiParamDefinition>[
              AbiParamDefinition(name: 'address', type: SolidityAddressType()),
            ]),
          )
        ],
      );

      List<int> actualBytes = HexCodec.decode('0x'
          '00000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c'
          '0000000000000000000000000000000000000000000000000000000000000001'
          '00000000000000000000000000000000000000000000000000000000000004d2'
          '00000000000000000000000000000000000000000000000000000000000010e1'
          '0000000000000000000000000000000000000000000000000000000000000001'
          '0000000000000000000000000000000000000000000000000000000000000002'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0000000000000000000000000000000000000000000000000000000000000004'
          '0000000000000000000000000000000000000000000000000000000000000005'
          '0000000000000000000000000000000000000000000000000000000000000006'
          '0000000000000000000000000000000000000000000000000000000000000007'
          '0000000000000000000000000000000000000000000000000000000000000008'
          '0000000000000000000000000000000000000000000000000000000000000009'
          '000000000000000000000000000000000000000000000000000000000000000a'
          '0000000000000000000000000000000000000000000000000000000000000001'
          '0000000000000000000000000000000000000000000000000000000000000002'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0000000000000000000000000000000000000000000000000000000000000004'
          '0000000000000000000000000000000000000000000000000000000000000005'
          '0000000000000000000000000000000000000000000000000000000000000006'
          '0000000000000000000000000000000000000000000000000000000000000007'
          '0000000000000000000000000000000000000000000000000000000000000008'
          '0000000000000000000000000000000000000000000000000000000000000009'
          '00000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c');

      // Act
      Object actualTuple = actualSolidityTupleType.decode(actualBytes, 0);

      // Assert
      Map<String, dynamic> expectedTuple = <String, dynamic>{
        'address': '0x53bf0a18754873a8102625d8225af6a15a43423c',
        'bool': true,
        'int': '1234',
        'uint': '4321',
        'static_array': <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
        'nested_static_array': <List<String>>[
          <String>['1', '2', '3'],
          <String>['4', '5', '6'],
          <String>['7', '8', '9']
        ],
        'nested_tuple': <String, String>{'address': '0x53bf0a18754873a8102625d8225af6a15a43423c'}
      };

      expect(actualTuple, expectedTuple);
    });
  });

  group('Tests of SolidityTupleType.fixedSize getter', () {
    test('Should [return fixed size] for SolidityTupleType [containing DYNAMIC types]', () {
      // Arrange
      SolidityTupleType actualSolidityTupleType = SolidityTupleType(
        <AbiParamDefinition>[
          AbiParamDefinition(name: 'address', type: SolidityAddressType()),
          AbiParamDefinition(name: 'bool', type: SolidityBoolType()),
          AbiParamDefinition(name: 'bytes', type: SolidityBytesType('bytes')),
          AbiParamDefinition(name: 'dynamic_array', type: SolidityDynamicArrayType('int256[]')),
          AbiParamDefinition(name: 'nested_dynamic_array', type: SolidityDynamicArrayType('int256[][]')),
          AbiParamDefinition(name: 'int', type: SolidityIntType('int256')),
          AbiParamDefinition(name: 'uint', type: SolidityIntType('uint256')),
          AbiParamDefinition(name: 'static_array', type: SolidityStaticArrayType('int256[10]')),
          AbiParamDefinition(name: 'nested_static_array', type: SolidityStaticArrayType('int256[3][3]')),
          AbiParamDefinition(name: 'string', type: SolidityStringType()),
          AbiParamDefinition(
            name: 'nested_tuple',
            type: SolidityTupleType(<AbiParamDefinition>[
              AbiParamDefinition(name: 'address', type: SolidityAddressType()),
            ]),
          )
        ],
      );

      // Act
      int actualFixedSize = actualSolidityTupleType.fixedSize;

      // Assert
      int expectedFixedSize = 32;

      expect(actualFixedSize, expectedFixedSize);
    });

    test('Should [return fixed size] for SolidityTupleType [containing STATIC types only]', () {
      // Arrange
      SolidityTupleType actualSolidityTupleType = SolidityTupleType(
        <AbiParamDefinition>[
          AbiParamDefinition(name: 'address', type: SolidityAddressType()),
          AbiParamDefinition(name: 'bool', type: SolidityBoolType()),
          AbiParamDefinition(name: 'int', type: SolidityIntType('int256')),
          AbiParamDefinition(name: 'uint', type: SolidityIntType('uint256')),
          AbiParamDefinition(name: 'static_array', type: SolidityStaticArrayType('int256[10]')),
          AbiParamDefinition(name: 'nested_static_array', type: SolidityStaticArrayType('int256[3][3]')),
          AbiParamDefinition(
            name: 'nested_tuple',
            type: SolidityTupleType(<AbiParamDefinition>[
              AbiParamDefinition(name: 'address', type: SolidityAddressType()),
            ]),
          )
        ],
      );

      // Act
      int actualFixedSize = actualSolidityTupleType.fixedSize;

      // Assert
      int expectedFixedSize = 768;

      expect(actualFixedSize, expectedFixedSize);
    });
  });

  group('Tests of SolidityTupleType.hasDynamicSize getter', () {
    test('Should [return TRUE] for SolidityTupleType [containing DYNAMIC types]', () {
      // Arrange
      SolidityTupleType actualSolidityTupleType = SolidityTupleType(
        <AbiParamDefinition>[
          AbiParamDefinition(name: 'address', type: SolidityAddressType()),
          AbiParamDefinition(name: 'bool', type: SolidityBoolType()),
          AbiParamDefinition(name: 'bytes', type: SolidityBytesType('bytes')),
          AbiParamDefinition(name: 'dynamic_array', type: SolidityDynamicArrayType('int256[]')),
          AbiParamDefinition(name: 'nested_dynamic_array', type: SolidityDynamicArrayType('int256[][]')),
          AbiParamDefinition(name: 'int', type: SolidityIntType('int256')),
          AbiParamDefinition(name: 'uint', type: SolidityIntType('uint256')),
          AbiParamDefinition(name: 'static_array', type: SolidityStaticArrayType('int256[10]')),
          AbiParamDefinition(name: 'nested_static_array', type: SolidityStaticArrayType('int256[3][3]')),
          AbiParamDefinition(name: 'string', type: SolidityStringType()),
          AbiParamDefinition(
            name: 'nested_tuple',
            type: SolidityTupleType(<AbiParamDefinition>[
              AbiParamDefinition(name: 'address', type: SolidityAddressType()),
            ]),
          )
        ],
      );

      // Act
      bool actualDynamicSizeBool = actualSolidityTupleType.hasDynamicSize;

      // Assert
      expect(actualDynamicSizeBool, true);
    });

    test('Should [return FALSE] for SolidityTupleType [containing STATIC types only]', () {
      // Arrange
      SolidityTupleType actualSolidityTupleType = SolidityTupleType(
        <AbiParamDefinition>[
          AbiParamDefinition(name: 'address', type: SolidityAddressType()),
          AbiParamDefinition(name: 'bool', type: SolidityBoolType()),
          AbiParamDefinition(name: 'int', type: SolidityIntType('int256')),
          AbiParamDefinition(name: 'uint', type: SolidityIntType('uint256')),
          AbiParamDefinition(name: 'static_array', type: SolidityStaticArrayType('int256[10]')),
          AbiParamDefinition(name: 'nested_static_array', type: SolidityStaticArrayType('int256[3][3]')),
          AbiParamDefinition(
            name: 'nested_tuple',
            type: SolidityTupleType(<AbiParamDefinition>[
              AbiParamDefinition(name: 'address', type: SolidityAddressType()),
            ]),
          )
        ],
      );

      // Act
      bool actualDynamicSizeBool = actualSolidityTupleType.hasDynamicSize;

      // Assert
      expect(actualDynamicSizeBool, false);
    });
  });
}
