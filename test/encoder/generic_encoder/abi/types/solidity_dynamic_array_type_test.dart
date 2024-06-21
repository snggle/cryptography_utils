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
  group('Tests for SolidityDynamicArrayType with SolidityAddressType', () {
    SolidityDynamicArrayType actualSolidityDynamicArrayType = SolidityDynamicArrayType('address[]');

    group('Tests of SolidityDynamicArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityDynamicArrayType)', () {
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
            '0x000000000000000000000000000000000000000000000000000000000000000200000000000000000000000090f8bf6a479f320ead074411a4b0e7944ea8c9c1000000000000000000000000ffcf8fdee72ac11b5c542428b35eef5769c409f0');

        // Act
        List<dynamic> actualList = actualSolidityDynamicArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <String>['0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1', '0xffcf8fdee72ac11b5c542428b35eef5769c409f0'];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityDynamicArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityDynamicArrayType', () {
        // Act
        int actualFixedSize = actualSolidityDynamicArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 96;

        expect(actualFixedSize, expectedFixedSize);
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
            '0x0000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000');

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
        int expectedFixedSize = 128;

        expect(actualFixedSize, expectedFixedSize);
      });
    });
  });

  group('Tests for SolidityDynamicArrayType with SolidityBytesType', () {
    SolidityDynamicArrayType actualSolidityDynamicArrayType = SolidityDynamicArrayType('bytes[]');

    group('Tests of SolidityDynamicArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityDynamicArrayType', () {
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
            '0x0000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000901020304050607080900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009010203040506070809000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000');

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
      test('Should [return fixed size] for SolidityDynamicArrayType', () {
        // Act
        int actualFixedSize = actualSolidityDynamicArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 224;

        expect(actualFixedSize, expectedFixedSize);
      });
    });
  });

  group('Tests for SolidityDynamicArrayType with nested SolidityDynamicArrayType', () {
    SolidityDynamicArrayType actualSolidityDynamicArrayType = SolidityDynamicArrayType('bytes[][]');

    group('Tests of SolidityDynamicArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityDynamicArrayType', () {
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
            '0x0000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000901020304050607080900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009010203040506070809000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000009010203040506070809000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000901020304050607080900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000901020304050607080900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009010203040506070809000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000');

        // Act
        List<dynamic> actualList = actualSolidityDynamicArrayType.decode(actualBytes, 0);

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

    group('Tests of SolidityDynamicArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityDynamicArrayType', () {
        // Act
        int actualFixedSize = actualSolidityDynamicArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 704;

        expect(actualFixedSize, expectedFixedSize);
      });
    });
  });

  group('Tests for SolidityDynamicArrayType with SolidityIntType', () {
    SolidityDynamicArrayType actualSolidityDynamicArrayType = SolidityDynamicArrayType('int256[]');

    group('Tests of SolidityDynamicArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityDynamicArrayType', () {
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
            '0x0000000000000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000700000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000009');

        // Act
        List<dynamic> actualList = actualSolidityDynamicArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityDynamicArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityDynamicArrayType', () {
        // Act
        int actualFixedSize = actualSolidityDynamicArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 320;

        expect(actualFixedSize, expectedFixedSize);
      });
    });
  });

  group('Tests for SolidityDynamicArrayType with SolidityStaticArrayType', () {
    SolidityDynamicArrayType actualSolidityDynamicArrayType = SolidityDynamicArrayType('bytes[3][]');

    group('Tests of SolidityDynamicArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityDynamicArrayType', () {
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
            '0x0000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000901020304050607080900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009010203040506070809000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000901020304050607080900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009010203040506070809000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000901020304050607080900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009010203040506070809000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000');

        // Act
        List<dynamic> actualList = actualSolidityDynamicArrayType.decode(actualBytes, 0);

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

    group('Tests of SolidityDynamicArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityDynamicArrayType', () {
        // Act
        int actualFixedSize = actualSolidityDynamicArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 608;

        expect(actualFixedSize, expectedFixedSize);
      });
    });
  });

  group('Tests for SolidityDynamicArrayType with SolidityStringType', () {
    SolidityDynamicArrayType actualSolidityDynamicArrayType = SolidityDynamicArrayType('string[]');

    group('Tests of SolidityDynamicArrayType.canonicalName getter', () {
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
            '0x0000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000c48656c6c6f20576f726c64210000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c48656c6c6f20576f726c64210000000000000000000000000000000000000000');

        // Act
        List<dynamic> actualList = actualSolidityDynamicArrayType.decode(actualBytes, 0);

        // Assert
        List<dynamic> expectedList = <String>['Hello World!', 'Hello World!'];

        expect(actualList, expectedList);
      });
    });

    group('Tests of SolidityDynamicArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityDynamicArrayType', () {
        // Act
        int actualFixedSize = actualSolidityDynamicArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 160;

        expect(actualFixedSize, expectedFixedSize);
      });
    });
  });

  group('Tests for SolidityDynamicArrayType with SolidityTupleType', () {
    SolidityDynamicArrayType actualSolidityDynamicArrayType = SolidityDynamicArrayType(
      'tuple[]',
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

    group('Tests of SolidityDynamicArrayType.canonicalName getter', () {
      test('Should [return canonical name] for SolidityDynamicArrayType', () {
        // Act
        String actualCanonicalName = actualSolidityDynamicArrayType.canonicalName;

        // Assert
        String expectedCanonicalName = 'tuple[]';

        expect(actualCanonicalName, expectedCanonicalName);
      });
    });

    group('Tests of SolidityDynamicArrayType.decode()', () {
      test('Should [return List of maps] decoded from given bytes', () {
        // Arrange
        List<int> actualBytes = HexEncoder.decode(
            '0x000000000000000000000000000000000000000000000000000000000000000200000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000070000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000004d2000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000700000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000c48656c6c6f20576f726c6421000000000000000000000000000000000000000000000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000070000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000004d2000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000700000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000c48656c6c6f20576f726c6421000000000000000000000000000000000000000000000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000070000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000004d2000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000700000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000c48656c6c6f20576f726c6421000000000000000000000000000000000000000000000000000000000000000053bf0a18754873a8102625d8225af6a15a43423c000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000090102030405060708090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000070000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000004d2000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000700000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000c48656c6c6f20576f726c64210000000000000000000000000000000000000000');

        // Act
        List<dynamic> actualList = actualSolidityDynamicArrayType.decode(actualBytes, 0);

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

    group('Tests of SolidityDynamicArrayType.fixedSize getter', () {
      test('Should [return fixed size] for SolidityDynamicArrayType', () {
        // Act
        int actualFixedSize = actualSolidityDynamicArrayType.fixedSize;

        // Assert
        int expectedFixedSize = 3360;

        expect(actualFixedSize, expectedFixedSize);
      });
    });
  });
}
