import 'package:cryptography_utils/src/encoder/generic_encoder/abi/functions/abi_param_definition.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_address_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_bool_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_bytes_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_dynamic_array_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_int_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_static_array_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_string_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/solidity_tuple_type.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/hex_encoder.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Tests for SolidityStaticArrayType with SolidityAddressType', () {
    SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('address[2]');

    group('Tests of SolidityStaticArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityStaticArrayType', () {
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
        List<int> actualBytes = HexEncoder.decode(
            '0x00000000000000000000000090f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000000ffcf8fdee72ac11b5c542428b35eef5769c409f0');

        // Act
        List<dynamic> actualList = actualSolidityStaticArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <String>['0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1', '0xffcf8fdee72ac11b5c542428b35eef5769c409f0'];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityStaticArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityStaticArrayType', () {
        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 64;

        expect(actualFixedSize, expectedFixedSize);
      });
    });
  });

  group('Tests for SolidityStaticArrayType with SolidityBoolType', () {
    SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('bool[3]');

    group('Tests of SolidityStaticArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityStaticArrayType', () {
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
        List<int> actualBytes = HexEncoder.decode(
            '0x000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000');

        // Act
        List<dynamic> actualList = actualSolidityStaticArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <bool>[true, true, false];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityStaticArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityStaticArrayType', () {
        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 96;

        expect(actualFixedSize, expectedFixedSize);
      });
    });
  });

  group('Tests for SolidityStaticArrayType with SolidityBytesType', () {
    SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('bytes[3]');

    group('Tests of SolidityStaticArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityStaticArrayType', () {
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
        List<int> actualBytes = HexEncoder.decode(
            '0x000000000000000000000000000000000000000000000000000000000000000901020304050607080900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009010203040506070809000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000');

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
      test('Should [return fixed size] for SolidityStaticArrayType', () {
        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 192;

        expect(actualFixedSize, expectedFixedSize);
      });
    });
  });

  group('Tests for SolidityStaticArrayType with SolidityDynamicArrayType', () {
    SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('bytes[][3]');

    group('Tests of SolidityStaticArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityStaticArrayType', () {
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
        List<int> actualBytes = HexEncoder.decode(
            '0x000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000901020304050607080900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009010203040506070809000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000009010203040506070809000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000901020304050607080900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000901020304050607080900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009010203040506070809000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000');

        // Act
        List<dynamic> actualList = actualSolidityStaticArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <List<List<int>>>[
          <List<int>>[
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9]
          ],
          <List<int>>[
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9]
          ],
          <List<int>>[
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9]
          ]
        ];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityStaticArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityStaticArrayType', () {
        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 672;

        expect(actualFixedSize, expectedFixedSize);
      });
    });
  });

  group('Tests for SolidityStaticArrayType with SolidityIntType', () {
    SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('int256[9]');

    group('Tests of SolidityStaticArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityStaticArrayType', () {
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
        List<int> actualBytes = HexEncoder.decode(
            '0x000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000700000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000009');

        // Act
        List<dynamic> actualList = actualSolidityStaticArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityStaticArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityStaticArrayType', () {
        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 288;

        expect(actualFixedSize, expectedFixedSize);
      });
    });
  });

  group('Tests for SolidityStaticArrayType with nested SolidityStaticArrayType', () {
    SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('bytes[3][3]');

    group('Tests of SolidityStaticArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityStaticArrayType', () {
        // Act
        String actualCanonicalName = actualSolidityStaticArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = 'bytes[3][3]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityStaticArrayType.decode()', () {
      test('Should [return List of bytes] decoded from given bytes', () {
        // Arrange
        List<int> actualBytes = HexEncoder.decode(
            '0x000000000000000000000000000000000000000000000000000000000000000901020304050607080900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009010203040506070809000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000901020304050607080900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009010203040506070809000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000901020304050607080900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009010203040506070809000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000');

        // Act
        List<dynamic> actualList = actualSolidityStaticArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <List<List<int>>>[
          <List<int>>[
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9]
          ],
          <List<int>>[
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9]
          ],
          <List<int>>[
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
            <int>[1, 2, 3, 4, 5, 6, 7, 8, 9]
          ]
        ];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityStaticArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityStaticArrayType', () {
        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 576;

        expect(actualFixedSize, expectedFixedSize);
      });
    });
  });

  group('Tests for SolidityStaticArrayType with SolidityStringType', () {
    SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType('string[2]');

    group('Tests of SolidityStaticArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityStaticArrayType', () {
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
        List<int> actualBytes = HexEncoder.decode(
            '0x000000000000000000000000000000000000000000000000000000000000000c48656c6c6f20576f726c64210000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c48656c6c6f20576f726c64210000000000000000000000000000000000000000');

        // Act
        List<dynamic> actualList = actualSolidityStaticArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <String>['Hello World!', 'Hello World!'];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityStaticArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityStaticArrayType', () {
        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 128;

        expect(actualFixedSize, expectedFixedSize);
      });
    });
  });

  group('Tests for SolidityStaticArrayType with SolidityTupleType', () {
    SolidityStaticArrayType actualSolidityStaticArrayType = SolidityStaticArrayType(
      'tuple[2]',
      <AbiParamDefinition>[
        AbiParamDefinition(name: 'address', type: SolidityAddressType()),
        AbiParamDefinition(name: 'bool', type: SolidityBoolType()),
        AbiParamDefinition(name: 'bytes', type: SolidityBytesType()),
        AbiParamDefinition(name: 'dynamic_array', type: SolidityDynamicArrayType('int256[]')),
        AbiParamDefinition(name: 'int', type: SolidityIntType('int256')),
        AbiParamDefinition(name: 'static_array', type: SolidityStaticArrayType('int256[9]')),
        AbiParamDefinition(name: 'string', type: SolidityStringType()),
        AbiParamDefinition(
          name: 'nested_tuple',
          type: SolidityTupleType(<AbiParamDefinition>[
            AbiParamDefinition(name: 'address', type: SolidityAddressType()),
            AbiParamDefinition(name: 'bool', type: SolidityBoolType()),
            AbiParamDefinition(name: 'bytes', type: SolidityBytesType()),
            AbiParamDefinition(name: 'dynamic_array', type: SolidityDynamicArrayType('int256[]')),
            AbiParamDefinition(name: 'int', type: SolidityIntType('int256')),
            AbiParamDefinition(name: 'static_array', type: SolidityStaticArrayType('int256[9]')),
            AbiParamDefinition(name: 'string', type: SolidityStringType())
          ]),
        )
      ],
    );

    group('Tests of SolidityStaticArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityStaticArrayType', () {
        // Act
        String actualCanonicalName = actualSolidityStaticArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = 'tuple[2]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityStaticArrayType.decode()', () {
      test('Should [return String] decoded from given bytes', () {
        List<int> actualBytes = HexEncoder.decode(
            '0x00000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000070000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000004d2000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000700000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000c48656c6c6f20576f726c6421000000000000000000000000000000000000000000000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000070000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000004d2000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000700000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000c48656c6c6f20576f726c6421000000000000000000000000000000000000000000000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000070000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000004d2000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000700000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000c48656c6c6f20576f726c6421000000000000000000000000000000000000000000000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000070000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000004d2000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000700000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000c48656c6c6f20576f726c64210000000000000000000000000000000000000000');

        // Act
        List<dynamic> actualList = actualSolidityStaticArrayType.decode(actualBytes, 0);

        // Assert
        List<Map<String, dynamic>> expectedList = <Map<String, dynamic>>[
          <String, dynamic>{
            'address': '0x53bf0a18754873a8102625d8225af6a15a43423c',
            'bool': true,
            'bytes': <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
            'dynamic_array': <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'],
            'int': '1234',
            'static_array': <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'],
            'string': 'Hello World!',
            'nested_tuple': <String, dynamic>{
              'address': '0x53bf0a18754873a8102625d8225af6a15a43423c',
              'bool': true,
              'bytes': <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
              'dynamic_array': <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'],
              'int': '1234',
              'static_array': <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'],
              'string': 'Hello World!'
            }
          },
          <String, dynamic>{
            'address': '0x53bf0a18754873a8102625d8225af6a15a43423c',
            'bool': true,
            'bytes': <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
            'dynamic_array': <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'],
            'int': '1234',
            'static_array': <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'],
            'string': 'Hello World!',
            'nested_tuple': <String, dynamic>{
              'address': '0x53bf0a18754873a8102625d8225af6a15a43423c',
              'bool': true,
              'bytes': <int>[1, 2, 3, 4, 5, 6, 7, 8, 9],
              'dynamic_array': <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'],
              'int': '1234',
              'static_array': <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'],
              'string': 'Hello World!'
            }
          }
        ];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityStaticArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityStaticArrayType', () {
        // Act
        int actualFixedSize = actualSolidityStaticArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 3328;

        expect(actualFixedSize, expectedFixedSize);
      });
    });
  });
}
