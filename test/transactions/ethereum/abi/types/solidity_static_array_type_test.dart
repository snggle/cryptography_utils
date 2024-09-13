import 'package:codec_utils/src/codecs/hex/hex_codec.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/functions/abi_param_definition.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_address_type.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_bytes_type.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_static_array_type.dart';
import 'package:cryptography_utils/src/transactions/ethereum/abi/solidity_types/solidity_tuple_type.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Tests for SolidityStaticArrayType with SolidityAddressType', () {
    SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('address[2]');

    group('Tests of SolidityStaticArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityStaticArrayType with SolidityAddressType', () {
        // Act
        String actualCanonicalName = actualSolidityStaticArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = 'address[2]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityStaticArrayType.decode()', () {
      test('Should [return List of addresses] decoded from given bytes', () {
        // Arrange
        List<int> actualBytes = HexCodec.decode(
          '0x'
          '00000000000000000000000090f8bf6a479f320ead074411a4b0e7944ea8c9c1'
          '000000000000000000000000ffcf8fdee72ac11b5c542428b35eef5769c409f0',
        );

        // Act
        List<dynamic> actualList = actualSolidityStaticArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <String>['0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1', '0xffcf8fdee72ac11b5c542428b35eef5769c409f0'];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityStaticArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityStaticArrayType with SolidityAddressType', () {
        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 64;

        expect(actualFixedSize, expectedFixedSize);
      });
    });

    group('Tests of SolidityStaticArrayType.hasDynamicSize getter', () {
      test('Should [return FALSE] for SolidityStaticArrayType with SolidityAddressType', () {
        // Act
        bool actualDynamicSizeBool = actualSolidityStaticArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, false);
      });
    });
  });

  group('Tests for SolidityStaticArrayType with SolidityBoolType', () {
    SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('bool[3]');

    group('Tests of SolidityStaticArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityStaticArrayType with SolidityBoolType', () {
        // Act
        String actualCanonicalName = actualSolidityStaticArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = 'bool[3]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityStaticArrayType.decode()', () {
      test('Should [return List of bool] decoded from given bytes', () {
        // Arrange
        List<int> actualBytes = HexCodec.decode(
          '0x'
          '0000000000000000000000000000000000000000000000000000000000000001'
          '0000000000000000000000000000000000000000000000000000000000000001'
          '0000000000000000000000000000000000000000000000000000000000000000',
        );

        // Act
        List<dynamic> actualList = actualSolidityStaticArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <bool>[true, true, false];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityStaticArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityStaticArrayType with SolidityBoolType', () {
        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 96;

        expect(actualFixedSize, expectedFixedSize);
      });
    });

    group('Tests of SolidityStaticArrayType.hasDynamicSize getter', () {
      test('Should [return FALSE] for SolidityStaticArrayType with SolidityBoolType', () {
        // Act
        bool actualDynamicSizeBool = actualSolidityStaticArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, false);
      });
    });
  });

  group('Tests for SolidityStaticArrayType with SolidityBytesType', () {
    SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('bytes[3]');

    group('Tests of SolidityStaticArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityStaticArrayType with SolidityBytesType', () {
        // Act
        String actualCanonicalName = actualSolidityStaticArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = 'bytes[3]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityStaticArrayType.decode()', () {
      test('Should [return List of bytes] decoded from given bytes', () {
        // Arrange
        List<int> actualBytes = HexCodec.decode(
          '0x'
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
        List<dynamic> actualList = actualSolidityStaticArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <List<int>>[
          <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
          <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
          <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
        ];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityStaticArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityStaticArrayType with SolidityBytesType', () {
        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 32;

        expect(actualFixedSize, expectedFixedSize);
      });
    });

    group('Tests of SolidityStaticArrayType.hasDynamicSize getter', () {
      test('Should [return TRUE] for SolidityStaticArrayType with SolidityBytesType', () {
        // Act
        bool actualDynamicSizeBool = actualSolidityStaticArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, true);
      });
    });
  });

  group('Tests for SolidityStaticArrayType with SolidityDynamicArrayType', () {
    SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('bytes[][3]');

    group('Tests of SolidityStaticArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityStaticArrayType with SolidityDynamicArrayType', () {
        // Act
        String actualCanonicalName = actualSolidityStaticArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = 'bytes[][3]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityStaticArrayType.decode()', () {
      test('Should [return List of bytes] decoded from given bytes', () {
        // Arrange
        List<int> actualBytes = HexCodec.decode(
          '0x'
          '0000000000000000000000000000000000000000000000000000000000000060'
          '00000000000000000000000000000000000000000000000000000000000001a0'
          '00000000000000000000000000000000000000000000000000000000000002e0'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0000000000000000000000000000000000000000000000000000000000000060'
          '00000000000000000000000000000000000000000000000000000000000000a0'
          '00000000000000000000000000000000000000000000000000000000000000e0'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0102030000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0405060000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0708090000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0000000000000000000000000000000000000000000000000000000000000060'
          '00000000000000000000000000000000000000000000000000000000000000a0'
          '00000000000000000000000000000000000000000000000000000000000000e0'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0a0b0c0000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0d0e0f0000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '1011120000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0000000000000000000000000000000000000000000000000000000000000060'
          '00000000000000000000000000000000000000000000000000000000000000a0'
          '00000000000000000000000000000000000000000000000000000000000000e0'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '1314150000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '1617180000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '191a1b0000000000000000000000000000000000000000000000000000000000',
        );

        // Act
        List<dynamic> actualList = actualSolidityStaticArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <List<List<int>>>[
          <List<int>>[
            <int>[1, 2, 3],
            <int>[4, 5, 6],
            <int>[7, 8, 9]
          ],
          <List<int>>[
            <int>[10, 11, 12],
            <int>[13, 14, 15],
            <int>[16, 17, 18]
          ],
          <List<int>>[
            <int>[19, 20, 21],
            <int>[22, 23, 24],
            <int>[25, 26, 27]
          ]
        ];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityStaticArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityStaticArrayType with SolidityDynamicArrayType', () {
        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 32;

        expect(actualFixedSize, expectedFixedSize);
      });
    });

    group('Tests of SolidityStaticArrayType.hasDynamicSize getter', () {
      test('Should [return TRUE] for SolidityStaticArrayType with SolidityDynamicArrayType', () {
        // Act
        bool actualDynamicSizeBool = actualSolidityStaticArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, true);
      });
    });
  });

  group('Tests for SolidityStaticArrayType with SolidityIntType', () {
    SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('int256[9]');

    group('Tests of SolidityStaticArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityStaticArrayType with SolidityIntType', () {
        // Act
        String actualCanonicalName = actualSolidityStaticArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = 'int256[9]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityStaticArrayType.decode()', () {
      test('Should [return List of String numbers] decoded from given bytes', () {
        // Arrange
        List<int> actualBytes = HexCodec.decode(
          '0x'
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
        List<dynamic> actualList = actualSolidityStaticArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityStaticArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityStaticArrayType with SolidityIntType', () {
        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 288;

        expect(actualFixedSize, expectedFixedSize);
      });
    });

    group('Tests of SolidityStaticArrayType.hasDynamicSize getter', () {
      test('Should [return FALSE] for SolidityStaticArrayType with SolidityIntType', () {
        // Act
        bool actualDynamicSizeBool = actualSolidityStaticArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, false);
      });
    });
  });

  group('Tests for SolidityStaticArrayType with nested SolidityStaticArrayType', () {
    group('Tests of SolidityStaticArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityStaticArrayType with nested SolidityStaticArrayType', () {
        // Arrange
        SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('bytes[3][3]');

        // Act
        String actualCanonicalName = actualSolidityStaticArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = 'bytes[3][3]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityStaticArrayType.decode()', () {
      test('Should [return List of bytes] decoded from nested SolidityStaticArrayType bytes [containing DYNAMIC types]', () {
        // Arrange
        SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('bytes[3][3]');
        List<int> actualBytes = HexCodec.decode(
          '0x'
          '0000000000000000000000000000000000000000000000000000000000000060'
          '0000000000000000000000000000000000000000000000000000000000000180'
          '00000000000000000000000000000000000000000000000000000000000002a0'
          '0000000000000000000000000000000000000000000000000000000000000060'
          '00000000000000000000000000000000000000000000000000000000000000a0'
          '00000000000000000000000000000000000000000000000000000000000000e0'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0102030000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0405060000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0708090000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000060'
          '00000000000000000000000000000000000000000000000000000000000000a0'
          '00000000000000000000000000000000000000000000000000000000000000e0'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0a0b0c0000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '0d0e0f0000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '1011120000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000060'
          '00000000000000000000000000000000000000000000000000000000000000a0'
          '00000000000000000000000000000000000000000000000000000000000000e0'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '1314150000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '1617180000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000003'
          '191a1b0000000000000000000000000000000000000000000000000000000000',
        );

        // Act
        List<dynamic> actualList = actualSolidityStaticArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <List<List<int>>>[
          <List<int>>[
            <int>[1, 2, 3],
            <int>[4, 5, 6],
            <int>[7, 8, 9]
          ],
          <List<int>>[
            <int>[10, 11, 12],
            <int>[13, 14, 15],
            <int>[16, 17, 18]
          ],
          <List<int>>[
            <int>[19, 20, 21],
            <int>[22, 23, 24],
            <int>[25, 26, 27]
          ]
        ];

        expect(actualList, expectedList);
      });

      test('Should [return List of bytes] decoded from nested SolidityStaticArrayType bytes [containing STATIC types only]', () {
        // Arrange
        SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('uint256[3][3]');
        List<int> actualBytes = HexCodec.decode(
          '0x'
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
        List<dynamic> actualList = actualSolidityStaticArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <List<String>>[
          <String>['1', '2', '3'],
          <String>['4', '5', '6'],
          <String>['7', '8', '9']
        ];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityStaticArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityStaticArrayType with nested SolidityStaticArrayType [containing DYNAMIC types]', () {
        // Arrange
        SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('bytes[3][3]');

        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 32;

        expect(actualFixedSize, expectedFixedSize);
      });

      test('Should [return fixed size] for SolidityStaticArrayType with nested SolidityStaticArrayType [containing STATIC types only]', () {
        // Arrange
        SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('uint256[3][3]');

        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 288;

        expect(actualFixedSize, expectedFixedSize);
      });
    });

    group('Tests of SolidityStaticArrayType.hasDynamicSize getter', () {
      test('Should [return TRUE] for SolidityStaticArrayType with nested SolidityStaticArrayType [containing DYNAMIC types]', () {
        // Arrange
        SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('bytes[3][3]');

        // Act
        bool actualDynamicSizeBool = actualSolidityStaticArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, true);
      });

      test('Should [return FALSE] for SolidityStaticArrayType with nested SolidityStaticArrayType [containing STATIC types only]', () {
        // Arrange
        SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('uint256[3][3]');

        // Act
        bool actualDynamicSizeBool = actualSolidityStaticArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, false);
      });
    });
  });

  group('Tests for SolidityStaticArrayType with SolidityStringType', () {
    SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('string[2]');

    group('Tests of SolidityStaticArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityStaticArrayType with SolidityStringType', () {
        // Act
        String actualCanonicalName = actualSolidityStaticArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = 'string[2]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityStaticArrayType.decode()', () {
      test('Should [return List of String] decoded from given bytes', () {
        // Arrange
        List<int> actualBytes = HexCodec.decode(
          '0x'
          '0000000000000000000000000000000000000000000000000000000000000040'
          '0000000000000000000000000000000000000000000000000000000000000080'
          '000000000000000000000000000000000000000000000000000000000000000c'
          '48656c6c6f20576f726c64210000000000000000000000000000000000000000'
          '000000000000000000000000000000000000000000000000000000000000000c'
          '48656c6c6f20576f726c64210000000000000000000000000000000000000000',
        );

        // Act
        List<dynamic> actualList = actualSolidityStaticArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <String>['Hello World!', 'Hello World!'];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityStaticArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityStaticArrayType with SolidityStringType', () {
        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 32;

        expect(actualFixedSize, expectedFixedSize);
      });
    });

    group('Tests of SolidityStaticArrayType.hasDynamicSize getter', () {
      test('Should [return TRUE] for SolidityStaticArrayType with SolidityStringType', () {
        // Act
        bool actualDynamicSizeBool = actualSolidityStaticArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, true);
      });
    });
  });

  group('Tests for SolidityStaticArrayType with SolidityTupleType', () {
    group('Tests of SolidityStaticArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityStaticArrayType', () {
        // Arrange
        SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType(
          'tuple[2]',
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

        // Act
        String actualCanonicalName = actualSolidityStaticArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = '(address,(address))[2]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityStaticArrayType.decode()', () {
      test('Should [return String] decoded from SolidityTupleType bytes [containing DYNAMIC types]', () {
        // Arrange
        SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType(
          'tuple[2]',
          <AbiParamDefinition>[
            AbiParamDefinition(name: 'bytes', type: SolidityBytesType('bytes')),
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
          '0000000000000000000000000000000000000000000000000000000000000040'
          '00000000000000000000000000000000000000000000000000000000000000C0'
          '0000000000000000000000000000000000000000000000000000000000000080'
          '00000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c'
          '0000000000000000000000000000000000000000000000000000000000000001'
          '1000000000000000000000000000000000000000000000000000000000000000'
          '0000000000000000000000000000000000000000000000000000000000000100'
          '00000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c'
          '0000000000000000000000000000000000000000000000000000000000000001'
          '1000000000000000000000000000000000000000000000000000000000000000',
        );

        // Act
        List<dynamic> actualList = actualSolidityStaticArrayType.decode(actualBytes, 0);

        // Assert
        List<Map<String, dynamic>> expectedList = <Map<String, dynamic>>[
          <String, dynamic>{
            'bytes': <int>[16],
            'nested_tuple': <String, String>{'address': '0x53bf0a18754873a8102625d8225af6a15a43423c'}
          },
          <String, dynamic>{
            'bytes': <int>[16],
            'nested_tuple': <String, String>{'address': '0x53bf0a18754873a8102625d8225af6a15a43423c'}
          }
        ];

        expect(actualList, expectedList);
      });

      test('Should [return String] decoded from SolidityTupleType bytes [containing STATIC types only]', () {
        // Arrange
        SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType(
          'tuple[2]',
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

        List<int> actualBytes = HexCodec.decode(
          '0x'
          '00000000000000000000002053bf0a18754873a8102625d8225af6a15a43423c'
          '00000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c'
          '00000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c'
          '00000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c',
        );

        // Act
        List<dynamic> actualList = actualSolidityStaticArrayType.decode(actualBytes, 0);

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

    group('Tests of SolidityStaticArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityStaticArrayType with SolidityTupleType [containing DYNAMIC types]', () {
        // Arrange
        SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType(
          'tuple[2]',
          <AbiParamDefinition>[
            AbiParamDefinition(name: 'bytes', type: SolidityBytesType('bytes')),
            AbiParamDefinition(
              name: 'nested_tuple',
              type: SolidityTupleType(<AbiParamDefinition>[
                AbiParamDefinition(name: 'address', type: SolidityAddressType()),
              ]),
            )
          ],
        );

        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 32;

        expect(actualFixedSize, expectedFixedSize);
      });

      test('Should [return fixed size] for SolidityStaticArrayType with SolidityTupleType [containing STATIC types only]', () {
        // Arrange
        SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType(
          'tuple[2]',
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

        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 128;

        expect(actualFixedSize, expectedFixedSize);
      });
    });

    group('Tests of SolidityStaticArrayType.hasDynamicSize getter', () {
      test('Should [return TRUE] for SolidityStaticArrayType with SolidityTupleType [containing DYNAMIC types]', () {
        // Arrange
        SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType(
          'tuple[2]',
          <AbiParamDefinition>[
            AbiParamDefinition(name: 'bytes', type: SolidityBytesType('bytes')),
            AbiParamDefinition(
              name: 'nested_tuple',
              type: SolidityTupleType(<AbiParamDefinition>[
                AbiParamDefinition(name: 'bytes', type: SolidityBytesType('bytes')),
              ]),
            )
          ],
        );

        // Act
        bool actualDynamicSizeBool = actualSolidityStaticArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, true);
      });

      test('Should [return FALSE] for SolidityStaticArrayType with SolidityTupleType [containing STATIC types only]', () {
        // Arrange
        SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType(
          'tuple[2]',
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

        // Act
        bool actualDynamicSizeBool = actualSolidityStaticArrayType.hasDynamicSize;

        // Assert
        expect(actualDynamicSizeBool, false);
      });
    });
  });
}
