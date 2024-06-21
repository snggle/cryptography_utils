import 'package:cryptography_utils/src/encoder/generic_encoder/abi/abi_definition.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/abi_param_definition.dart';
import 'package:cryptography_utils/src/encoder/generic_encoder/abi/solidity_types/export.dart';

class UniswapCommandsAbi {
  static Map<int, ABIDefinition> commandsAbi = <int, ABIDefinition>{
    0x00: ABIDefinition(
      name: 'V3_SWAP_EXACT_IN',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'input_amount', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'output_amount', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'path', type: SolidityBytesType()),
        ABIParamDefinition(name: 'flag', type: BoolType()),
      ],
    ),
    0x01: ABIDefinition(
      name: 'V3_SWAP_EXACT_OUT',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'input_amount', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'output_amount', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'path', type: SolidityBytesType()),
        ABIParamDefinition(name: 'flag', type: BoolType()),
      ],
    ),
    0x02: ABIDefinition(
      name: 'PERMIT2_TRANSFER_FROM',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'token_address', type: SolidityAddressType()),
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
      ],
    ),
    0x03: ABIDefinition(
      name: 'PERMIT2_PERMIT_BATCH',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(
          name: 'details',
          type: SolidityTupleType(
            types: <ABIParamDefinition>[
              ABIParamDefinition(
                name: 'details',
                type: SolidityTupleType(
                  types: <ABIParamDefinition>[
                    ABIParamDefinition(name: 'token_address', type: SolidityAddressType()),
                    ABIParamDefinition(name: 'amount', type: SolidityIntType('uint160', keepSegmentSizeBool: false)),
                    ABIParamDefinition(name: 'expiration', type: SolidityIntType('uint48', keepSegmentSizeBool: false)),
                    ABIParamDefinition(name: 'nonce', type: SolidityIntType('uint48', keepSegmentSizeBool: false)),
                  ],
                ),
              ),
              ABIParamDefinition(name: 'spender', type: SolidityAddressType()),
              ABIParamDefinition(name: 'sig_deadline', type: SolidityIntType('uint256')),
            ],
          ),
        ),
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
      ],
    ),
    0x04: ABIDefinition(
      name: 'SWEEP',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'token_address', type: SolidityAddressType()),
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
      ],
    ),
    0x05: ABIDefinition(
      name: 'TRANSFER',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'token_address', type: SolidityAddressType()),
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
      ],
    ),
    0x06: ABIDefinition(
      name: 'PAY_PORTION',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'token_address', type: SolidityAddressType()),
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
      ],
    ),
    0x08: ABIDefinition(
      name: 'V2_SWAP_EXACT_IN',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'input_amount', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'output_amount', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'address', type: SolidityDynamicArrayType('address[]')),
        ABIParamDefinition(name: 'flag', type: BoolType()),
      ],
    ),
    0x09: ABIDefinition(
      name: 'V2_SWAP_EXACT_OUT',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'input_amount', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'output_amount', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'address', type: SolidityDynamicArrayType('address[]')),
        ABIParamDefinition(name: 'flag', type: BoolType()),
      ],
    ),
    0x0a: ABIDefinition(name: 'PERMIT2_PERMIT'),
    0x0b: ABIDefinition(
      name: 'WRAP_ETH',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
      ],
    ),
    0x0c: ABIDefinition(
      name: 'UNWRAP_WETH',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
      ],
    ),
    0x0d: ABIDefinition(
      name: 'PERMIT2_TRANSFER_FROM_BATCH',
      inputs: const <ABIParamDefinition>[],
    ),
    0x10: ABIDefinition(
      name: 'SEAPORT',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'calldata', type: SolidityBytesType()),
      ],
    ),
    0x11: ABIDefinition(
      name: 'LOOKS_RARE_721',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'calldata', type: SolidityBytesType()),
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'token_address', type: SolidityAddressType()),
        ABIParamDefinition(name: 'id', type: SolidityIntType('uint256')),
      ],
    ),
    0x12: ABIDefinition(
      name: 'NFTX',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'calldata', type: SolidityBytesType()),
      ],
    ),
    0x13: ABIDefinition(
      name: 'CRYPTOPUNKS',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'punk_id', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
      ],
    ),
    0x14: ABIDefinition(
      name: 'LOOKS_RARE_1155',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'calldata', type: SolidityBytesType()),
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'token_address', type: SolidityAddressType()),
        ABIParamDefinition(name: 'id', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
      ],
    ),
    0x15: ABIDefinition(
      name: 'OWNER_CHECK_721',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'owner', type: SolidityAddressType()),
        ABIParamDefinition(name: 'token_address', type: SolidityAddressType()),
        ABIParamDefinition(name: 'id', type: SolidityIntType('uint256')),
      ],
    ),
    0x16: ABIDefinition(
      name: 'OWNER_CHECK_1155',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'owner', type: SolidityAddressType()),
        ABIParamDefinition(name: 'token_address', type: SolidityAddressType()),
        ABIParamDefinition(name: 'id', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
      ],
    ),
    0x17: ABIDefinition(
      name: 'SWEEP_ERC721',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'token_address', type: SolidityAddressType()),
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'id', type: SolidityIntType('uint256')),
      ],
    ),
    0x18: ABIDefinition(
      name: 'X2Y2_721',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'calldata', type: SolidityBytesType()),
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'token_address', type: SolidityAddressType()),
        ABIParamDefinition(name: 'id', type: SolidityIntType('uint256')),
      ],
    ),
    0x19: ABIDefinition(
      name: 'SUDOSWAP',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'calldata', type: SolidityBytesType()),
      ],
    ),
    0x1a: ABIDefinition(
      name: 'NFT20',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'calldata', type: SolidityBytesType()),
      ],
    ),
    0x1b: ABIDefinition(
      name: 'X2Y2_1155',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'calldata', type: SolidityBytesType()),
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'token_address', type: SolidityAddressType()),
        ABIParamDefinition(name: 'id', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
      ],
    ),
    0x1c: ABIDefinition(
      name: 'FOUNDATION',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'calldata', type: SolidityBytesType()),
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'token_address', type: SolidityAddressType()),
        ABIParamDefinition(name: 'id', type: SolidityIntType('uint256')),
      ],
    ),
    0x1d: ABIDefinition(
      name: 'SWEEP_ERC1155',
      inputs: <ABIParamDefinition>[
        ABIParamDefinition(name: 'token_address', type: SolidityAddressType()),
        ABIParamDefinition(name: 'recipient', type: SolidityAddressType()),
        ABIParamDefinition(name: 'id', type: SolidityIntType('uint256')),
        ABIParamDefinition(name: 'amount', type: SolidityIntType('uint256')),
      ],
    ),
  };
}
