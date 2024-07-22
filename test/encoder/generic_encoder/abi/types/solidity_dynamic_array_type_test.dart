import 'package:cryptography_utils/src/encoder/generic_encoder/abi/functions/abi_param_definition.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_address_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_dynamic_array_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_tuple_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/hex_encoder.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Tests for SolidityDynamicArrayType with SolidityAddressType', () {
    SolidityDynamicArrayType actualSolidityDynamicArrayType = SolidityDynamicArrayType('address[]');

    group('Tests of SolidityDynamicArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityDynamicArrayType with SolidityBoolType', () {
        // Act
        String actualCanonicalName = actualSolidityDynamicArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = 'address[]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityDynamicArrayType.decode()', () {
      test('Should [return List of addresses] decoded from given bytes', () {
        // Arrange
        List<int> actualBytes = HexEncoder.decode(
          '0x'
          '0000000000000000000000000000000000000000000000000000000000000002'
          '00000000000000000000000090f8bf6a479f320ead074411a4b0e7944ea8c9c1'
          '000000000000000000000000ffcf8fdee72ac11b5c542428b35eef5769c409f0',
        );

        // Act
        List<dynamic> actualList = actualSolidityDynamicArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <String>['0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1', '0xffcf8fdee72ac11b5c542428b35eef5769c409f0'];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityDynamicArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityDynamicArrayType with SolidityBoolType', () {
        // Act
        int actualFixedSize = actualSolidityDynamicArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 32;

        expect(actualFixedSize, expectedFixedSize);
      });
    });

    group('Tests of SolidityDynamicArrayType.hasDynamicSize getter', () {
      test('Should [return TRUE] for SolidityDynamicArrayType with SolidityAddressType', () {
        // Act
        bool actualDynamicSizeBool = actualSolidityDynamicArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, true);
      });
    });
  });

  group('Tests for SolidityDynamicArrayType with SolidityBoolType', () {
    SolidityDynamicArrayType actualSolidityDynamicArrayType = SolidityDynamicArrayType('bool[]');

    group('Tests of SolidityDynamicArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityDynamicArrayType', () {
        // Act
        String actualCanonicalName = actualSolidityDynamicArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = 'bool[]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityDynamicArrayType.decode()', () {
      test('Should [return List of bool] decoded from given bytes', () {
        // Arrange
        List<int> actualBytes = HexEncoder.decode(
          '0x'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0000000000000000000000000000000000000000000000000000000000000001'
          '0000000000000000000000000000000000000000000000000000000000000001'
          '0000000000000000000000000000000000000000000000000000000000000000',
        );

        // Act
        List<dynamic> actualList = actualSolidityDynamicArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <bool>[true, true, false];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityDynamicArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityDynamicArrayType', () {
        // Act
        int actualFixedSize = actualSolidityDynamicArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 32;

        expect(actualFixedSize, expectedFixedSize);
      });
    });

    group('Tests of SolidityDynamicArrayType.hasDynamicSize getter', () {
      test('Should [return TRUE] for SolidityDynamicArrayType with SolidityBoolType', () {
        // Act
        bool actualDynamicSizeBool = actualSolidityDynamicArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, true);
      });
    });
  });

  group('Tests for SolidityDynamicArrayType with SolidityBytesType', () {
    SolidityDynamicArrayType actualSolidityDynamicArrayType = SolidityDynamicArrayType('bytes[]');

    group('Tests of SolidityDynamicArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityDynamicArrayType with SolidityBytesType', () {
        // Act
        String actualCanonicalName = actualSolidityDynamicArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = 'bytes[]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityDynamicArrayType.decode()', () {
      test('Should [return List of bytes] decoded from given bytes', () {
        // Arrange
        List<int> actualBytes = HexEncoder.decode(
          '0x'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0000000000000000000000000000000000000000000000000000000000000060'
          '00000000000000000000000000000000000000000000000000000000000000a0'
          '00000000000000000000000000000000000000000000000000000000000000e0'
          '0000000000000000000000000000000000000000000000000000000000000009'
          '0102030405060708090000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000009'
          '0102030405060708090000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000009'
          '0102030405060708090000000000000000000000000000000000000000000000',
        );

        // Act
        List<dynamic> actualList = actualSolidityDynamicArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <List<int>>[
          <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
          <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
          <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
        ];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityDynamicArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityDynamicArrayType with SolidityBytesType', () {
        // Act
        int actualFixedSize = actualSolidityDynamicArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 32;

        expect(actualFixedSize, expectedFixedSize);
      });
    });

    group('Tests of SolidityDynamicArrayType.hasDynamicSize getter', () {
      test('Should [return TRUE] for SolidityDynamicArrayType with SolidityBytesType', () {
        // Act
        bool actualDynamicSizeBool = actualSolidityDynamicArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, true);
      });
    });
  });

  group('Tests for SolidityDynamicArrayType with nested SolidityDynamicArrayType', () {
    SolidityDynamicArrayType actualSolidityDynamicArrayType = SolidityDynamicArrayType('bytes[][]');

    group('Tests of SolidityDynamicArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityDynamicArrayType with nested SolidityDynamicArrayType', () {
        // Act
        String actualCanonicalName = actualSolidityDynamicArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = 'bytes[][]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityDynamicArrayType.decode()', () {
      test('Should [return List of bytes] decoded from given bytes', () {
        // Arrange
        List<int> actualBytes = HexEncoder.decode(
          '0x'
          '0000000000000000000000000000000000000000000000000000000000000002'
          '0000000000000000000000000000000000000000000000000000000000000040'
          '0000000000000000000000000000000000000000000000000000000000000180'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0000000000000000000000000000000000000000000000000000000000000060'
          '00000000000000000000000000000000000000000000000000000000000000a0'
          '00000000000000000000000000000000000000000000000000000000000000e0'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0001020000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0304050000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0607080000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0000000000000000000000000000000000000000000000000000000000000060'
          '00000000000000000000000000000000000000000000000000000000000000a0'
          '00000000000000000000000000000000000000000000000000000000000000e0'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '090a0b0000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0c0d0e0000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0f10110000000000000000000000000000000000000000000000000000000000',
        );

        // Act
        List<dynamic> actualList = actualSolidityDynamicArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <List<List<int>>>[
          <List<int>>[
            <int>[0, 1, 2],
            <int>[3, 4, 5],
            <int>[6, 7, 8]
          ],
          <List<int>>[
            <int>[9, 10, 11],
            <int>[12, 13, 14],
            <int>[15, 16, 17]
          ],
        ];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityDynamicArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityDynamicArrayType with nested SolidityDynamicArrayType', () {
        // Act
        int actualFixedSize = actualSolidityDynamicArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 32;

        expect(actualFixedSize, expectedFixedSize);
      });
    });

    group('Tests of SolidityDynamicArrayType.hasDynamicSize getter', () {
      test('Should [return TRUE] for SolidityDynamicArrayType with nested SolidityDynamicArrayType', () {
        // Act
        bool actualDynamicSizeBool = actualSolidityDynamicArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, true);
      });
    });
  });

  group('Tests for SolidityDynamicArrayType with SolidityIntType', () {
    SolidityDynamicArrayType actualSolidityDynamicArrayType = SolidityDynamicArrayType('int256[]');

    group('Tests of SolidityDynamicArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityDynamicArrayType with SolidityIntType', () {
        // Act
        String actualCanonicalName = actualSolidityDynamicArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = 'int256[]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityDynamicArrayType.decode()', () {
      test('Should [return List of String numbers] decoded from given bytes', () {
        // Arrange
        List<int> actualBytes = HexEncoder.decode(
          '0x'
          '0000000000000000000000000000000000000000000000000000000000000009'
          '0000000000000000000000000000000000000000000000000000000000000001'
          '0000000000000000000000000000000000000000000000000000000000000002'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0000000000000000000000000000000000000000000000000000000000000004'
          '0000000000000000000000000000000000000000000000000000000000000005'
          '0000000000000000000000000000000000000000000000000000000000000006'
          '0000000000000000000000000000000000000000000000000000000000000007'
          '0000000000000000000000000000000000000000000000000000000000000008'
          '0000000000000000000000000000000000000000000000000000000000000009',
        );

        // Act
        List<dynamic> actualList = actualSolidityDynamicArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityDynamicArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityDynamicArrayType with SolidityIntType', () {
        // Act
        int actualFixedSize = actualSolidityDynamicArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 32;

        expect(actualFixedSize, expectedFixedSize);
      });
    });

    group('Tests of SolidityDynamicArrayType.hasDynamicSize getter', () {
      test('Should [return TRUE] for SolidityDynamicArrayType with SolidityIntType', () {
        // Act
        bool actualDynamicSizeBool = actualSolidityDynamicArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, true);
      });
    });
  });

  group('Tests for SolidityDynamicArrayType with SolidityStaticArrayType', () {
    SolidityDynamicArrayType actualSolidityDynamicArrayType = SolidityDynamicArrayType('bytes[3][]');

    group('Tests of SolidityDynamicArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityDynamicArrayType with SolidityStaticArrayType', () {
        // Act
        String actualCanonicalName = actualSolidityDynamicArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = 'bytes[3][]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityDynamicArrayType.decode()', () {
      test('Should [return List of bytes] decoded from given bytes', () {
        // Arrange
        List<int> actualBytes = HexEncoder.decode(
          '0x'
          '0000000000000000000000000000000000000000000000000000000000000002'
          '0000000000000000000000000000000000000000000000000000000000000040'
          '0000000000000000000000000000000000000000000000000000000000000160'
          '0000000000000000000000000000000000000000000000000000000000000060'
          '00000000000000000000000000000000000000000000000000000000000000a0'
          '00000000000000000000000000000000000000000000000000000000000000e0'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0001020000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0304050000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0607080000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000060'
          '00000000000000000000000000000000000000000000000000000000000000a0'
          '00000000000000000000000000000000000000000000000000000000000000e0'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '090a0b0000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0c0d0e0000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0f10110000000000000000000000000000000000000000000000000000000000',
        );

        // Act
        List<dynamic> actualList = actualSolidityDynamicArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <List<List<int>>>[
          <List<int>>[
            <int>[0, 1, 2],
            <int>[3, 4, 5],
            <int>[6, 7, 8]
          ],
          <List<int>>[
            <int>[9, 10, 11],
            <int>[12, 13, 14],
            <int>[15, 16, 17]
          ],
        ];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityDynamicArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityDynamicArrayType with SolidityStaticArrayType', () {
        // Act
        int actualFixedSize = actualSolidityDynamicArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 32;

        expect(actualFixedSize, expectedFixedSize);
      });
    });

    group('Tests of SolidityDynamicArrayType.hasDynamicSize getter', () {
      test('Should [return TRUE] for SolidityDynamicArrayType with SolidityStaticArrayType', () {
        // Act
        bool actualDynamicSizeBool = actualSolidityDynamicArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, true);
      });
    });
  });

  group('Tests for SolidityDynamicArrayType with SolidityStringType', () {
    SolidityDynamicArrayType actualSolidityDynamicArrayType = SolidityDynamicArrayType('string[]');

    group('Tests of SolidityDynamicArrayType.canonicalName getter with SolidityStringType', () {
      test('Should [return canonical name] for SolidityDynamicArrayType', () {
        // Act
        String actualCanonicalName = actualSolidityDynamicArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = 'string[]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityDynamicArrayType.decode()', () {
      test('Should [return List of String] decoded from given bytes', () {
        // Arrange
        List<int> actualBytes = HexEncoder.decode(
          '0x'
          '0000000000000000000000000000000000000000000000000000000000000002'
          '0000000000000000000000000000000000000000000000000000000000000040'
          '0000000000000000000000000000000000000000000000000000000000000080'
          '000000000000000000000000000000000000000000000000000000000000000c'
          '48656c6c6f20576f726c64210000000000000000000000000000000000000000'
          '000000000000000000000000000000000000000000000000000000000000000c'
          '48656c6c6f20576f726c64210000000000000000000000000000000000000000',
        );

        // Act
        List<dynamic> actualList = actualSolidityDynamicArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <String>['Hello World!', 'Hello World!'];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityDynamicArrayType.fixedSize getter with SolidityStringType', () {
      test('Should [return fixed size] for SolidityDynamicArrayType', () {
        // Act
        int actualFixedSize = actualSolidityDynamicArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 32;

        expect(actualFixedSize, expectedFixedSize);
      });
    });

    group('Tests of SolidityDynamicArrayType.hasDynamicSize getter', () {
      test('Should [return TRUE] for SolidityDynamicArrayType with SolidityStringType', () {
        // Act
        bool actualDynamicSizeBool = actualSolidityDynamicArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, true);
      });
    });
  });

  group('Tests for SolidityDynamicArrayType with SolidityTupleType', () {
    SolidityDynamicArrayType actualSolidityDynamicArrayType = SolidityDynamicArrayType(
      'tuple[]',
      <AbiParamDefinition>[
        AbiParamDefinition(name: 'address', type: SolidityAddressType()),
        AbiParamDefinition(
          name: 'nested_tuple',
          type: SolidityTupleType(<AbiParamDefinition>[
            AbiParamDefinition(name: 'address', type: SolidityAddressType()),
          ]),
        )
      ],
    );

    group('Tests of SolidityDynamicArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityDynamicArrayType with SolidityTupleType', () {
        // Act
        String actualCanonicalName = actualSolidityDynamicArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = '(address,(address))[]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityDynamicArrayType.decode()', () {
      test('Should [return List of maps] decoded from given bytes', () {
        // Arrange
        List<int> actualBytes = HexEncoder.decode(
          '0x'
          '0000000000000000000000000000000000000000000000000000000000000002'
          '00000000000000000000002053bf0a18754873a8102625d8225af6a15a43423c'
          '00000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c'
          '00000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c'
          '00000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c',
        );

        // Act
        List<dynamic> actualList = actualSolidityDynamicArrayType.decode(actualBytes, 0);

        // Assert
        List<Map<String, dynamic>> expectedList = <Map<String, dynamic>>[
          <String, dynamic>{
            'address': '0x53bf0a18754873a8102625d8225af6a15a43423c',
            'nested_tuple': <String, String>{'address': '0x53bf0a18754873a8102625d8225af6a15a43423c'}
          },
          <String, dynamic>{
            'address': '0x53bf0a18754873a8102625d8225af6a15a43423c',
            'nested_tuple': <String, String>{'address': '0x53bf0a18754873a8102625d8225af6a15a43423c'}
          }
        ];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityDynamicArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityDynamicArrayType with SolidityTupleType', () {
        // Act
        int actualFixedSize = actualSolidityDynamicArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 32;

        expect(actualFixedSize, expectedFixedSize);
      });
    });

    group('Tests of SolidityDynamicArrayType.hasDynamicSize getter', () {
      test('Should [return TRUE] for SolidityDynamicArrayType with SolidityTupleType', () {
        // Act
        bool actualDynamicSizeBool = actualSolidityDynamicArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, true);
      });
    });
  });
}
