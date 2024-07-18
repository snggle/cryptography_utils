/// Class containing all supported ABIs
class AbiLibrary {
  /// ABI for ERC20 contract
  /// https://github.com/bloq/erc-20-abi/blob/master/src/abi.json
  static List<Map<String, Object>> erc20 = <Map<String, Object>>[
    <String, Object>{
      'inputs': <Map<String, String>>[],
      'name': 'name',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'string', 'name': '', 'type': 'string'}
      ],
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[],
      'name': 'symbol',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'string', 'name': '', 'type': 'string'}
      ],
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[],
      'name': 'decimals',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint8', 'name': '', 'type': 'uint8'}
      ],
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[],
      'name': 'totalSupply',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': '', 'type': 'uint256'}
      ],
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'account', 'type': 'address'}
      ],
      'name': 'balanceOf',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': '', 'type': 'uint256'}
      ],
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'amount', 'type': 'uint256'}
      ],
      'name': 'transfer',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'bool', 'name': '', 'type': 'bool'}
      ],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'sender', 'type': 'address'},
        <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'amount', 'type': 'uint256'}
      ],
      'name': 'transferFrom',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'bool', 'name': '', 'type': 'bool'}
      ],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'spender', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'amount', 'type': 'uint256'}
      ],
      'name': 'approve',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'bool', 'name': '', 'type': 'bool'}
      ],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'owner', 'type': 'address'},
        <String, String>{'internalType': 'address', 'name': 'spender', 'type': 'address'}
      ],
      'name': 'allowance',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': '', 'type': 'uint256'}
      ],
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'anonymous': false,
      'inputs': <Map<String, Object>>[
        <String, Object>{'indexed': true, 'internalType': 'address', 'name': 'from', 'type': 'address'},
        <String, Object>{'indexed': true, 'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, Object>{'indexed': false, 'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
      ],
      'name': 'Transfer',
      'type': 'event'
    },
    <String, Object>{
      'anonymous': false,
      'inputs': <Map<String, Object>>[
        <String, Object>{'indexed': true, 'internalType': 'address', 'name': 'owner', 'type': 'address'},
        <String, Object>{'indexed': true, 'internalType': 'address', 'name': 'spender', 'type': 'address'},
        <String, Object>{'indexed': false, 'internalType': 'uint256', 'name': 'value', 'type': 'uint256'}
      ],
      'name': 'Approval',
      'type': 'event'
    }
  ];

  static List<Map<String, Object>> uniswapUniversalRouter = <Map<String, Object>>[
    <String, Object>{
      'inputs': <Map<String, Object>>[
        <String, Object>{
          'components': <Map<String, String>>[
            <String, String>{'internalType': 'address', 'name': 'permit2', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'weth9', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'seaportV1_5', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'seaportV1_4', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'openseaConduit', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'nftxZap', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'x2y2', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'foundation', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'sudoswap', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'elementMarket', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'nft20Zap', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'cryptopunks', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'looksRareV2', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'routerRewardsDistributor', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'looksRareRewardsDistributor', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'looksRareToken', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'v2Factory', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'v3Factory', 'type': 'address'},
            <String, String>{'internalType': 'bytes32', 'name': 'pairInitCodeHash', 'type': 'bytes32'},
            <String, String>{'internalType': 'bytes32', 'name': 'poolInitCodeHash', 'type': 'bytes32'}
          ],
          'internalType': 'struct RouterParameters',
          'name': 'params',
          'type': 'tuple'
        }
      ],
      'stateMutability': 'nonpayable',
      'type': 'constructor'
    },
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'BalanceTooLow', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'BuyPunkFailed', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'ContractLocked', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'ETHNotAccepted', 'type': 'error'},
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'commandIndex', 'type': 'uint256'},
        <String, String>{'internalType': 'bytes', 'name': 'message', 'type': 'bytes'}
      ],
      'name': 'ExecutionFailed',
      'type': 'error'
    },
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'FromAddressIsNotOwner', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'InsufficientETH', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'InsufficientToken', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'InvalidBips', 'type': 'error'},
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'commandType', 'type': 'uint256'}
      ],
      'name': 'InvalidCommandType',
      'type': 'error'
    },
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'InvalidOwnerERC1155', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'InvalidOwnerERC721', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'InvalidPath', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'InvalidReserves', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'InvalidSpender', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'LengthMismatch', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'SliceOutOfBounds', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'TransactionDeadlinePassed', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'UnableToClaim', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'UnsafeCast', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'V2InvalidPath', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'V2TooLittleReceived', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'V2TooMuchRequested', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'V3InvalidAmountOut', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'V3InvalidCaller', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'V3InvalidSwap', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'V3TooLittleReceived', 'type': 'error'},
    <String, Object>{'inputs': <Map<String, String>>[], 'name': 'V3TooMuchRequested', 'type': 'error'},
    <String, Object>{
      'anonymous': false,
      'inputs': <Map<String, Object>>[
        <String, Object>{'indexed': false, 'internalType': 'uint256', 'name': 'amount', 'type': 'uint256'}
      ],
      'name': 'RewardsSent',
      'type': 'event'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'bytes', 'name': 'looksRareClaim', 'type': 'bytes'}
      ],
      'name': 'collectRewards',
      'outputs': <Map<String, String>>[],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'bytes', 'name': 'commands', 'type': 'bytes'},
        <String, String>{'internalType': 'bytes[]', 'name': 'inputs', 'type': 'bytes[]'},
      ],
      'name': 'execute',
      'outputs': <Map<String, String>>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'bytes', 'name': 'commands', 'type': 'bytes'},
        <String, String>{'internalType': 'bytes[]', 'name': 'inputs', 'type': 'bytes[]'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'}
      ],
      'name': 'execute',
      'outputs': <Map<String, String>>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': '', 'type': 'address'},
        <String, String>{'internalType': 'address', 'name': '', 'type': 'address'},
        <String, String>{'internalType': 'uint256[]', 'name': '', 'type': 'uint256[]'},
        <String, String>{'internalType': 'uint256[]', 'name': '', 'type': 'uint256[]'},
        <String, String>{'internalType': 'bytes', 'name': '', 'type': 'bytes'}
      ],
      'name': 'onERC1155BatchReceived',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'bytes4', 'name': '', 'type': 'bytes4'}
      ],
      'stateMutability': 'pure',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': '', 'type': 'address'},
        <String, String>{'internalType': 'address', 'name': '', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': '', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': '', 'type': 'uint256'},
        <String, String>{'internalType': 'bytes', 'name': '', 'type': 'bytes'}
      ],
      'name': 'onERC1155Received',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'bytes4', 'name': '', 'type': 'bytes4'}
      ],
      'stateMutability': 'pure',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': '', 'type': 'address'},
        <String, String>{'internalType': 'address', 'name': '', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': '', 'type': 'uint256'},
        <String, String>{'internalType': 'bytes', 'name': '', 'type': 'bytes'}
      ],
      'name': 'onERC721Received',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'bytes4', 'name': '', 'type': 'bytes4'}
      ],
      'stateMutability': 'pure',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'bytes4', 'name': 'interfaceId', 'type': 'bytes4'}
      ],
      'name': 'supportsInterface',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'bool', 'name': '', 'type': 'bool'}
      ],
      'stateMutability': 'pure',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'int256', 'name': 'amount0Delta', 'type': 'int256'},
        <String, String>{'internalType': 'int256', 'name': 'amount1Delta', 'type': 'int256'},
        <String, String>{'internalType': 'bytes', 'name': 'data', 'type': 'bytes'}
      ],
      'name': 'uniswapV3SwapCallback',
      'outputs': <Map<String, String>>[],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{'stateMutability': 'payable', 'type': 'receive'}
  ];

  static List<Map<String, Object>> uniswapV2Router02 = <Map<String, Object>>[
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': '_factory', 'type': 'address'},
        <String, String>{'internalType': 'address', 'name': '_WETH', 'type': 'address'}
      ],
      'stateMutability': 'nonpayable',
      'type': 'constructor'
    },
    <String, Object>{
      'inputs': <dynamic>[],
      'name': 'WETH',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': '', 'type': 'address'}
      ],
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'tokenA', 'type': 'address'},
        <String, String>{'internalType': 'address', 'name': 'tokenB', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'amountADesired', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountBDesired', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountAMin', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountBMin', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'}
      ],
      'name': 'addLiquidity',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountA', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountB', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'liquidity', 'type': 'uint256'}
      ],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'token', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'amountTokenDesired', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountTokenMin', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountETHMin', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'}
      ],
      'name': 'addLiquidityETH',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountToken', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountETH', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'liquidity', 'type': 'uint256'}
      ],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <dynamic>[],
      'name': 'factory',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': '', 'type': 'address'}
      ],
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountOut', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'reserveIn', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'reserveOut', 'type': 'uint256'}
      ],
      'name': 'getAmountIn',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountIn', 'type': 'uint256'}
      ],
      'stateMutability': 'pure',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountIn', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'reserveIn', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'reserveOut', 'type': 'uint256'}
      ],
      'name': 'getAmountOut',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountOut', 'type': 'uint256'}
      ],
      'stateMutability': 'pure',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountOut', 'type': 'uint256'},
        <String, String>{'internalType': 'address[]', 'name': 'path', 'type': 'address[]'}
      ],
      'name': 'getAmountsIn',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256[]', 'name': 'amounts', 'type': 'uint256[]'}
      ],
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountIn', 'type': 'uint256'},
        <String, String>{'internalType': 'address[]', 'name': 'path', 'type': 'address[]'}
      ],
      'name': 'getAmountsOut',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256[]', 'name': 'amounts', 'type': 'uint256[]'}
      ],
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountA', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'reserveA', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'reserveB', 'type': 'uint256'}
      ],
      'name': 'quote',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountB', 'type': 'uint256'}
      ],
      'stateMutability': 'pure',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'tokenA', 'type': 'address'},
        <String, String>{'internalType': 'address', 'name': 'tokenB', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'liquidity', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountAMin', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountBMin', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'}
      ],
      'name': 'removeLiquidity',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountA', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountB', 'type': 'uint256'}
      ],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'token', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'liquidity', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountTokenMin', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountETHMin', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'}
      ],
      'name': 'removeLiquidityETH',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountToken', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountETH', 'type': 'uint256'}
      ],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'token', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'liquidity', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountTokenMin', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountETHMin', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'}
      ],
      'name': 'removeLiquidityETHSupportingFeeOnTransferTokens',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountETH', 'type': 'uint256'}
      ],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'token', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'liquidity', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountTokenMin', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountETHMin', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
        <String, String>{'internalType': 'bool', 'name': 'approveMax', 'type': 'bool'},
        <String, String>{'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
        <String, String>{'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
        <String, String>{'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
      ],
      'name': 'removeLiquidityETHWithPermit',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountToken', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountETH', 'type': 'uint256'}
      ],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'token', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'liquidity', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountTokenMin', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountETHMin', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
        <String, String>{'internalType': 'bool', 'name': 'approveMax', 'type': 'bool'},
        <String, String>{'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
        <String, String>{'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
        <String, String>{'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
      ],
      'name': 'removeLiquidityETHWithPermitSupportingFeeOnTransferTokens',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountETH', 'type': 'uint256'}
      ],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'tokenA', 'type': 'address'},
        <String, String>{'internalType': 'address', 'name': 'tokenB', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'liquidity', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountAMin', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountBMin', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
        <String, String>{'internalType': 'bool', 'name': 'approveMax', 'type': 'bool'},
        <String, String>{'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
        <String, String>{'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
        <String, String>{'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
      ],
      'name': 'removeLiquidityWithPermit',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountA', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountB', 'type': 'uint256'}
      ],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountOut', 'type': 'uint256'},
        <String, String>{'internalType': 'address[]', 'name': 'path', 'type': 'address[]'},
        <String, String>{'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'}
      ],
      'name': 'swapETHForExactTokens',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256[]', 'name': 'amounts', 'type': 'uint256[]'}
      ],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountOutMin', 'type': 'uint256'},
        <String, String>{'internalType': 'address[]', 'name': 'path', 'type': 'address[]'},
        <String, String>{'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'}
      ],
      'name': 'swapExactETHForTokens',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256[]', 'name': 'amounts', 'type': 'uint256[]'}
      ],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountOutMin', 'type': 'uint256'},
        <String, String>{'internalType': 'address[]', 'name': 'path', 'type': 'address[]'},
        <String, String>{'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'}
      ],
      'name': 'swapExactETHForTokensSupportingFeeOnTransferTokens',
      'outputs': <dynamic>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountIn', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountOutMin', 'type': 'uint256'},
        <String, String>{'internalType': 'address[]', 'name': 'path', 'type': 'address[]'},
        <String, String>{'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'}
      ],
      'name': 'swapExactTokensForETH',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256[]', 'name': 'amounts', 'type': 'uint256[]'}
      ],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountIn', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountOutMin', 'type': 'uint256'},
        <String, String>{'internalType': 'address[]', 'name': 'path', 'type': 'address[]'},
        <String, String>{'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'}
      ],
      'name': 'swapExactTokensForETHSupportingFeeOnTransferTokens',
      'outputs': <dynamic>[],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountIn', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountOutMin', 'type': 'uint256'},
        <String, String>{'internalType': 'address[]', 'name': 'path', 'type': 'address[]'},
        <String, String>{'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'}
      ],
      'name': 'swapExactTokensForTokens',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256[]', 'name': 'amounts', 'type': 'uint256[]'}
      ],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountIn', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountOutMin', 'type': 'uint256'},
        <String, String>{'internalType': 'address[]', 'name': 'path', 'type': 'address[]'},
        <String, String>{'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'}
      ],
      'name': 'swapExactTokensForTokensSupportingFeeOnTransferTokens',
      'outputs': <dynamic>[],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountOut', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountInMax', 'type': 'uint256'},
        <String, String>{'internalType': 'address[]', 'name': 'path', 'type': 'address[]'},
        <String, String>{'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'}
      ],
      'name': 'swapTokensForExactETH',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256[]', 'name': 'amounts', 'type': 'uint256[]'}
      ],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountOut', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'amountInMax', 'type': 'uint256'},
        <String, String>{'internalType': 'address[]', 'name': 'path', 'type': 'address[]'},
        <String, String>{'internalType': 'address', 'name': 'to', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'}
      ],
      'name': 'swapTokensForExactTokens',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256[]', 'name': 'amounts', 'type': 'uint256[]'}
      ],
      'stateMutability': 'nonpayable',
      'type': 'function'
    }
  ];

  static List<Map<String, Object>> uniswapV3Router = <Map<String, Object>>[
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': '_factory', 'type': 'address'},
        <String, String>{'internalType': 'address', 'name': '_WETH9', 'type': 'address'}
      ],
      'stateMutability': 'nonpayable',
      'type': 'constructor'
    },
    <String, Object>{
      'inputs': <dynamic>[],
      'name': 'WETH9',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': '', 'type': 'address'}
      ],
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, Object>>[
        <String, Object>{
          'components': <Map<String, String>>[
            <String, String>{'internalType': 'bytes', 'name': 'path', 'type': 'bytes'},
            <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'},
            <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
            <String, String>{'internalType': 'uint256', 'name': 'amountIn', 'type': 'uint256'},
            <String, String>{'internalType': 'uint256', 'name': 'amountOutMinimum', 'type': 'uint256'}
          ],
          'internalType': 'struct ISwapRouter.ExactInputParams',
          'name': 'params',
          'type': 'tuple'
        }
      ],
      'name': 'exactInput',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountOut', 'type': 'uint256'}
      ],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, Object>>[
        <String, Object>{
          'components': <Map<String, String>>[
            <String, String>{'internalType': 'address', 'name': 'tokenIn', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'tokenOut', 'type': 'address'},
            <String, String>{'internalType': 'uint24', 'name': 'fee', 'type': 'uint24'},
            <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'},
            <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
            <String, String>{'internalType': 'uint256', 'name': 'amountIn', 'type': 'uint256'},
            <String, String>{'internalType': 'uint256', 'name': 'amountOutMinimum', 'type': 'uint256'},
            <String, String>{'internalType': 'uint160', 'name': 'sqrtPriceLimitX96', 'type': 'uint160'}
          ],
          'internalType': 'struct ISwapRouter.ExactInputSingleParams',
          'name': 'params',
          'type': 'tuple'
        }
      ],
      'name': 'exactInputSingle',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountOut', 'type': 'uint256'}
      ],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, Object>>[
        <String, Object>{
          'components': <Map<String, String>>[
            <String, String>{'internalType': 'bytes', 'name': 'path', 'type': 'bytes'},
            <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'},
            <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
            <String, String>{'internalType': 'uint256', 'name': 'amountOut', 'type': 'uint256'},
            <String, String>{'internalType': 'uint256', 'name': 'amountInMaximum', 'type': 'uint256'}
          ],
          'internalType': 'struct ISwapRouter.ExactOutputParams',
          'name': 'params',
          'type': 'tuple'
        }
      ],
      'name': 'exactOutput',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountIn', 'type': 'uint256'}
      ],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, Object>>[
        <String, Object>{
          'components': <Map<String, String>>[
            <String, String>{'internalType': 'address', 'name': 'tokenIn', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'tokenOut', 'type': 'address'},
            <String, String>{'internalType': 'uint24', 'name': 'fee', 'type': 'uint24'},
            <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'},
            <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
            <String, String>{'internalType': 'uint256', 'name': 'amountOut', 'type': 'uint256'},
            <String, String>{'internalType': 'uint256', 'name': 'amountInMaximum', 'type': 'uint256'},
            <String, String>{'internalType': 'uint160', 'name': 'sqrtPriceLimitX96', 'type': 'uint160'}
          ],
          'internalType': 'struct ISwapRouter.ExactOutputSingleParams',
          'name': 'params',
          'type': 'tuple'
        }
      ],
      'name': 'exactOutputSingle',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountIn', 'type': 'uint256'}
      ],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <dynamic>[],
      'name': 'factory',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': '', 'type': 'address'}
      ],
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'bytes[]', 'name': 'data', 'type': 'bytes[]'}
      ],
      'name': 'multicall',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'bytes[]', 'name': 'results', 'type': 'bytes[]'}
      ],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{'inputs': <dynamic>[], 'name': 'refundETH', 'outputs': <dynamic>[], 'stateMutability': 'payable', 'type': 'function'},
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'token', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
        <String, String>{'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
        <String, String>{'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
        <String, String>{'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
      ],
      'name': 'selfPermit',
      'outputs': <dynamic>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'token', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'nonce', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'expiry', 'type': 'uint256'},
        <String, String>{'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
        <String, String>{'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
        <String, String>{'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
      ],
      'name': 'selfPermitAllowed',
      'outputs': <dynamic>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'token', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'nonce', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'expiry', 'type': 'uint256'},
        <String, String>{'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
        <String, String>{'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
        <String, String>{'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
      ],
      'name': 'selfPermitAllowedIfNecessary',
      'outputs': <dynamic>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'token', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
        <String, String>{'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
        <String, String>{'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
        <String, String>{'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
      ],
      'name': 'selfPermitIfNecessary',
      'outputs': <dynamic>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'token', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'amountMinimum', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'}
      ],
      'name': 'sweepToken',
      'outputs': <dynamic>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'token', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'amountMinimum', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'feeBips', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'feeRecipient', 'type': 'address'}
      ],
      'name': 'sweepTokenWithFee',
      'outputs': <dynamic>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'int256', 'name': 'amount0Delta', 'type': 'int256'},
        <String, String>{'internalType': 'int256', 'name': 'amount1Delta', 'type': 'int256'},
        <String, String>{'internalType': 'bytes', 'name': '_data', 'type': 'bytes'}
      ],
      'name': 'uniswapV3SwapCallback',
      'outputs': <dynamic>[],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountMinimum', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'}
      ],
      'name': 'unwrapWETH9',
      'outputs': <dynamic>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountMinimum', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'feeBips', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'feeRecipient', 'type': 'address'}
      ],
      'name': 'unwrapWETH9WithFee',
      'outputs': <dynamic>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{'stateMutability': 'payable', 'type': 'receive'}
  ];

  static List<Map<String, Object>> uniswapV3SwapRouter = <Map<String, Object>>[
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': '_factory', 'type': 'address'},
        <String, String>{'internalType': 'address', 'name': '_WETH9', 'type': 'address'}
      ],
      'stateMutability': 'nonpayable',
      'type': 'constructor'
    },
    <String, Object>{
      'inputs': <dynamic>[],
      'name': 'WETH9',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': '', 'type': 'address'}
      ],
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, Object>>[
        <String, Object>{
          'components': <Map<String, String>>[
            <String, String>{'internalType': 'bytes', 'name': 'path', 'type': 'bytes'},
            <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'},
            <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
            <String, String>{'internalType': 'uint256', 'name': 'amountIn', 'type': 'uint256'},
            <String, String>{'internalType': 'uint256', 'name': 'amountOutMinimum', 'type': 'uint256'}
          ],
          'internalType': 'struct ISwapRouter.ExactInputParams',
          'name': 'params',
          'type': 'tuple'
        }
      ],
      'name': 'exactInput',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountOut', 'type': 'uint256'}
      ],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, Object>>[
        <String, Object>{
          'components': <Map<String, String>>[
            <String, String>{'internalType': 'address', 'name': 'tokenIn', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'tokenOut', 'type': 'address'},
            <String, String>{'internalType': 'uint24', 'name': 'fee', 'type': 'uint24'},
            <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'},
            <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
            <String, String>{'internalType': 'uint256', 'name': 'amountIn', 'type': 'uint256'},
            <String, String>{'internalType': 'uint256', 'name': 'amountOutMinimum', 'type': 'uint256'},
            <String, String>{'internalType': 'uint160', 'name': 'sqrtPriceLimitX96', 'type': 'uint160'}
          ],
          'internalType': 'struct ISwapRouter.ExactInputSingleParams',
          'name': 'params',
          'type': 'tuple'
        }
      ],
      'name': 'exactInputSingle',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountOut', 'type': 'uint256'}
      ],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, Object>>[
        <String, Object>{
          'components': <Map<String, String>>[
            <String, String>{'internalType': 'bytes', 'name': 'path', 'type': 'bytes'},
            <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'},
            <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
            <String, String>{'internalType': 'uint256', 'name': 'amountOut', 'type': 'uint256'},
            <String, String>{'internalType': 'uint256', 'name': 'amountInMaximum', 'type': 'uint256'}
          ],
          'internalType': 'struct ISwapRouter.ExactOutputParams',
          'name': 'params',
          'type': 'tuple'
        }
      ],
      'name': 'exactOutput',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountIn', 'type': 'uint256'}
      ],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, Object>>[
        <String, Object>{
          'components': <Map<String, String>>[
            <String, String>{'internalType': 'address', 'name': 'tokenIn', 'type': 'address'},
            <String, String>{'internalType': 'address', 'name': 'tokenOut', 'type': 'address'},
            <String, String>{'internalType': 'uint24', 'name': 'fee', 'type': 'uint24'},
            <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'},
            <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
            <String, String>{'internalType': 'uint256', 'name': 'amountOut', 'type': 'uint256'},
            <String, String>{'internalType': 'uint256', 'name': 'amountInMaximum', 'type': 'uint256'},
            <String, String>{'internalType': 'uint160', 'name': 'sqrtPriceLimitX96', 'type': 'uint160'}
          ],
          'internalType': 'struct ISwapRouter.ExactOutputSingleParams',
          'name': 'params',
          'type': 'tuple'
        }
      ],
      'name': 'exactOutputSingle',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountIn', 'type': 'uint256'}
      ],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <dynamic>[],
      'name': 'factory',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': '', 'type': 'address'}
      ],
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'bytes[]', 'name': 'data', 'type': 'bytes[]'}
      ],
      'name': 'multicall',
      'outputs': <Map<String, String>>[
        <String, String>{'internalType': 'bytes[]', 'name': 'results', 'type': 'bytes[]'}
      ],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{'inputs': <dynamic>[], 'name': 'refundETH', 'outputs': <dynamic>[], 'stateMutability': 'payable', 'type': 'function'},
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'token', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
        <String, String>{'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
        <String, String>{'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
        <String, String>{'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
      ],
      'name': 'selfPermit',
      'outputs': <dynamic>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'token', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'nonce', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'expiry', 'type': 'uint256'},
        <String, String>{'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
        <String, String>{'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
        <String, String>{'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
      ],
      'name': 'selfPermitAllowed',
      'outputs': <dynamic>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'token', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'nonce', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'expiry', 'type': 'uint256'},
        <String, String>{'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
        <String, String>{'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
        <String, String>{'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
      ],
      'name': 'selfPermitAllowedIfNecessary',
      'outputs': <dynamic>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'token', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'value', 'type': 'uint256'},
        <String, String>{'internalType': 'uint256', 'name': 'deadline', 'type': 'uint256'},
        <String, String>{'internalType': 'uint8', 'name': 'v', 'type': 'uint8'},
        <String, String>{'internalType': 'bytes32', 'name': 'r', 'type': 'bytes32'},
        <String, String>{'internalType': 'bytes32', 'name': 's', 'type': 'bytes32'}
      ],
      'name': 'selfPermitIfNecessary',
      'outputs': <dynamic>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'token', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'amountMinimum', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'}
      ],
      'name': 'sweepToken',
      'outputs': <dynamic>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'address', 'name': 'token', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'amountMinimum', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'feeBips', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'feeRecipient', 'type': 'address'}
      ],
      'name': 'sweepTokenWithFee',
      'outputs': <dynamic>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'int256', 'name': 'amount0Delta', 'type': 'int256'},
        <String, String>{'internalType': 'int256', 'name': 'amount1Delta', 'type': 'int256'},
        <String, String>{'internalType': 'bytes', 'name': '_data', 'type': 'bytes'}
      ],
      'name': 'uniswapV3SwapCallback',
      'outputs': <dynamic>[],
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountMinimum', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'}
      ],
      'name': 'unwrapWETH9',
      'outputs': <dynamic>[],
      'stateMutability': 'payable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'internalType': 'uint256', 'name': 'amountMinimum', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'recipient', 'type': 'address'},
        <String, String>{'internalType': 'uint256', 'name': 'feeBips', 'type': 'uint256'},
        <String, String>{'internalType': 'address', 'name': 'feeRecipient', 'type': 'address'}
      ],
      'name': 'unwrapWETH9WithFee',
      'outputs': <dynamic>[],
      'stateMutability': 'payable',
      'type': 'function'
    }
  ];

  static List<Map<String, Object>> uniswapV3SwapRouter02 = <Map<String, Object>>[
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'_factoryV2',
          'type':'address'
        },
        <String, String>{
          'internalType':'address',
          'name':'factoryV3',
          'type':'address'
        },
        <String, String>{
          'internalType':'address',
          'name':'_positionManager',
          'type':'address'
        },
        <String, String>{
          'internalType':'address',
          'name':'_WETH9',
          'type':'address'
        }
      ],
      'stateMutability':'nonpayable',
      'type':'constructor'
    },
    <String, Object>{
      'inputs':<dynamic>[

      ],
      'name':'WETH9',
      'outputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'',
          'type':'address'
        }
      ],
      'stateMutability':'view',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'token',
          'type':'address'
        }
      ],
      'name':'approveMax',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'token',
          'type':'address'
        }
      ],
      'name':'approveMaxMinusOne',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'token',
          'type':'address'
        }
      ],
      'name':'approveZeroThenMax',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'token',
          'type':'address'
        }
      ],
      'name':'approveZeroThenMaxMinusOne',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'bytes',
          'name':'data',
          'type':'bytes'
        }
      ],
      'name':'callPositionManager',
      'outputs':<Map<String, String>>[
        <String, String>{
          'internalType':'bytes',
          'name':'result',
          'type':'bytes'
        }
      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'bytes[]',
          'name':'paths',
          'type':'bytes[]'
        },
        <String, String>{
          'internalType':'uint128[]',
          'name':'amounts',
          'type':'uint128[]'
        },
        <String, String>{
          'internalType':'uint24',
          'name':'maximumTickDivergence',
          'type':'uint24'
        },
        <String, String>{
          'internalType':'uint32',
          'name':'secondsAgo',
          'type':'uint32'
        }
      ],
      'name':'checkOracleSlippage',
      'outputs':<dynamic>[

      ],
      'stateMutability':'view',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'bytes',
          'name':'path',
          'type':'bytes'
        },
        <String, String>{
          'internalType':'uint24',
          'name':'maximumTickDivergence',
          'type':'uint24'
        },
        <String, String>{
          'internalType':'uint32',
          'name':'secondsAgo',
          'type':'uint32'
        }
      ],
      'name':'checkOracleSlippage',
      'outputs':<dynamic>[

      ],
      'stateMutability':'view',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, Object>>[
        <String, Object>{
          'components':<Map<String, String>>[
            <String, String>{
              'internalType':'bytes',
              'name':'path',
              'type':'bytes'
            },
            <String, String>{
              'internalType':'address',
              'name':'recipient',
              'type':'address'
            },
            <String, String>{
              'internalType':'uint256',
              'name':'amountIn',
              'type':'uint256'
            },
            <String, String>{
              'internalType':'uint256',
              'name':'amountOutMinimum',
              'type':'uint256'
            }
          ],
          'internalType':'struct IV3SwapRouter.ExactInputParams',
          'name':'params',
          'type':'tuple'
        }
      ],
      'name':'exactInput',
      'outputs':<Map<String, String>>[
        <String, String>{
          'internalType':'uint256',
          'name':'amountOut',
          'type':'uint256'
        }
      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, Object>>[
        <String, Object>{
          'components':<Map<String, String>>[
            <String, String>{
              'internalType':'address',
              'name':'tokenIn',
              'type':'address'
            },
            <String, String>{
              'internalType':'address',
              'name':'tokenOut',
              'type':'address'
            },
            <String, String>{
              'internalType':'uint24',
              'name':'fee',
              'type':'uint24'
            },
            <String, String>{
              'internalType':'address',
              'name':'recipient',
              'type':'address'
            },
            <String, String>{
              'internalType':'uint256',
              'name':'amountIn',
              'type':'uint256'
            },
            <String, String>{
              'internalType':'uint256',
              'name':'amountOutMinimum',
              'type':'uint256'
            },
            <String, String>{
              'internalType':'uint160',
              'name':'sqrtPriceLimitX96',
              'type':'uint160'
            }
          ],
          'internalType':'struct IV3SwapRouter.ExactInputSingleParams',
          'name':'params',
          'type':'tuple'
        }
      ],
      'name':'exactInputSingle',
      'outputs':<Map<String, String>>[
        <String, String>{
          'internalType':'uint256',
          'name':'amountOut',
          'type':'uint256'
        }
      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, Object>>[
        <String, Object>{
          'components':<Map<String, String>>[
            <String, String>{
              'internalType':'bytes',
              'name':'path',
              'type':'bytes'
            },
            <String, String>{
              'internalType':'address',
              'name':'recipient',
              'type':'address'
            },
            <String, String>{
              'internalType':'uint256',
              'name':'amountOut',
              'type':'uint256'
            },
            <String, String>{
              'internalType':'uint256',
              'name':'amountInMaximum',
              'type':'uint256'
            }
          ],
          'internalType':'struct IV3SwapRouter.ExactOutputParams',
          'name':'params',
          'type':'tuple'
        }
      ],
      'name':'exactOutput',
      'outputs':<Map<String, String>>[
        <String, String>{
          'internalType':'uint256',
          'name':'amountIn',
          'type':'uint256'
        }
      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, Object>>[
        <String, Object>{
          'components':<Map<String, String>>[
            <String, String>{
              'internalType':'address',
              'name':'tokenIn',
              'type':'address'
            },
            <String, String>{
              'internalType':'address',
              'name':'tokenOut',
              'type':'address'
            },
            <String, String>{
              'internalType':'uint24',
              'name':'fee',
              'type':'uint24'
            },
            <String, String>{
              'internalType':'address',
              'name':'recipient',
              'type':'address'
            },
            <String, String>{
              'internalType':'uint256',
              'name':'amountOut',
              'type':'uint256'
            },
            <String, String>{
              'internalType':'uint256',
              'name':'amountInMaximum',
              'type':'uint256'
            },
            <String, String>{
              'internalType':'uint160',
              'name':'sqrtPriceLimitX96',
              'type':'uint160'
            }
          ],
          'internalType':'struct IV3SwapRouter.ExactOutputSingleParams',
          'name':'params',
          'type':'tuple'
        }
      ],
      'name':'exactOutputSingle',
      'outputs':<Map<String, String>>[
        <String, String>{
          'internalType':'uint256',
          'name':'amountIn',
          'type':'uint256'
        }
      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<dynamic>[

      ],
      'name':'factory',
      'outputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'',
          'type':'address'
        }
      ],
      'stateMutability':'view',
      'type':'function'
    },
    <String, Object>{
      'inputs':<dynamic>[

      ],
      'name':'factoryV2',
      'outputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'',
          'type':'address'
        }
      ],
      'stateMutability':'view',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'token',
          'type':'address'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'amount',
          'type':'uint256'
        }
      ],
      'name':'getApprovalType',
      'outputs':<Map<String, String>>[
        <String, String>{
          'internalType':'enum IApproveAndCall.ApprovalType',
          'name':'',
          'type':'uint8'
        }
      ],
      'stateMutability':'nonpayable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, Object>>[
        <String, Object>{
          'components':<Map<String, String>>[
            <String, String>{
              'internalType':'address',
              'name':'token0',
              'type':'address'
            },
            <String, String>{
              'internalType':'address',
              'name':'token1',
              'type':'address'
            },
            <String, String>{
              'internalType':'uint256',
              'name':'tokenId',
              'type':'uint256'
            },
            <String, String>{
              'internalType':'uint256',
              'name':'amount0Min',
              'type':'uint256'
            },
            <String, String>{
              'internalType':'uint256',
              'name':'amount1Min',
              'type':'uint256'
            }
          ],
          'internalType':'struct IApproveAndCall.IncreaseLiquidityParams',
          'name':'params',
          'type':'tuple'
        }
      ],
      'name':'increaseLiquidity',
      'outputs':<Map<String, String>>[
        <String, String>{
          'internalType':'bytes',
          'name':'result',
          'type':'bytes'
        }
      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, Object>>[
        <String, Object>{
          'components':<Map<String, String>>[
            <String, String>{
              'internalType':'address',
              'name':'token0',
              'type':'address'
            },
            <String, String>{
              'internalType':'address',
              'name':'token1',
              'type':'address'
            },
            <String, String>{
              'internalType':'uint24',
              'name':'fee',
              'type':'uint24'
            },
            <String, String>{
              'internalType':'int24',
              'name':'tickLower',
              'type':'int24'
            },
            <String, String>{
              'internalType':'int24',
              'name':'tickUpper',
              'type':'int24'
            },
            <String, String>{
              'internalType':'uint256',
              'name':'amount0Min',
              'type':'uint256'
            },
            <String, String>{
              'internalType':'uint256',
              'name':'amount1Min',
              'type':'uint256'
            },
            <String, String>{
              'internalType':'address',
              'name':'recipient',
              'type':'address'
            }
          ],
          'internalType':'struct IApproveAndCall.MintParams',
          'name':'params',
          'type':'tuple'
        }
      ],
      'name':'mint',
      'outputs':<Map<String, String>>[
        <String, String>{
          'internalType':'bytes',
          'name':'result',
          'type':'bytes'
        }
      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'bytes32',
          'name':'previousBlockhash',
          'type':'bytes32'
        },
        <String, String>{
          'internalType':'bytes[]',
          'name':'data',
          'type':'bytes[]'
        }
      ],
      'name':'multicall',
      'outputs':<Map<String, String>>[
        <String, String>{
          'internalType':'bytes[]',
          'name':'',
          'type':'bytes[]'
        }
      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'uint256',
          'name':'deadline',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'bytes[]',
          'name':'data',
          'type':'bytes[]'
        }
      ],
      'name':'multicall',
      'outputs':<Map<String, String>>[
        <String, String>{
          'internalType':'bytes[]',
          'name':'',
          'type':'bytes[]'
        }
      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'bytes[]',
          'name':'data',
          'type':'bytes[]'
        }
      ],
      'name':'multicall',
      'outputs':<Map<String, String>>[
        <String, String>{
          'internalType':'bytes[]',
          'name':'results',
          'type':'bytes[]'
        }
      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<dynamic>[

      ],
      'name':'positionManager',
      'outputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'',
          'type':'address'
        }
      ],
      'stateMutability':'view',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'token',
          'type':'address'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'value',
          'type':'uint256'
        }
      ],
      'name':'pull',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<dynamic>[

      ],
      'name':'refundETH',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'token',
          'type':'address'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'value',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'deadline',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'uint8',
          'name':'v',
          'type':'uint8'
        },
        <String, String>{
          'internalType':'bytes32',
          'name':'r',
          'type':'bytes32'
        },
        <String, String>{
          'internalType':'bytes32',
          'name':'s',
          'type':'bytes32'
        }
      ],
      'name':'selfPermit',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'token',
          'type':'address'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'nonce',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'expiry',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'uint8',
          'name':'v',
          'type':'uint8'
        },
        <String, String>{
          'internalType':'bytes32',
          'name':'r',
          'type':'bytes32'
        },
        <String, String>{
          'internalType':'bytes32',
          'name':'s',
          'type':'bytes32'
        }
      ],
      'name':'selfPermitAllowed',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'token',
          'type':'address'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'nonce',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'expiry',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'uint8',
          'name':'v',
          'type':'uint8'
        },
        <String, String>{
          'internalType':'bytes32',
          'name':'r',
          'type':'bytes32'
        },
        <String, String>{
          'internalType':'bytes32',
          'name':'s',
          'type':'bytes32'
        }
      ],
      'name':'selfPermitAllowedIfNecessary',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'token',
          'type':'address'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'value',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'deadline',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'uint8',
          'name':'v',
          'type':'uint8'
        },
        <String, String>{
          'internalType':'bytes32',
          'name':'r',
          'type':'bytes32'
        },
        <String, String>{
          'internalType':'bytes32',
          'name':'s',
          'type':'bytes32'
        }
      ],
      'name':'selfPermitIfNecessary',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'uint256',
          'name':'amountIn',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'amountOutMin',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'address[]',
          'name':'path',
          'type':'address[]'
        },
        <String, String>{
          'internalType':'address',
          'name':'to',
          'type':'address'
        }
      ],
      'name':'swapExactTokensForTokens',
      'outputs':<Map<String, String>>[
        <String, String>{
          'internalType':'uint256',
          'name':'amountOut',
          'type':'uint256'
        }
      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'uint256',
          'name':'amountOut',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'amountInMax',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'address[]',
          'name':'path',
          'type':'address[]'
        },
        <String, String>{
          'internalType':'address',
          'name':'to',
          'type':'address'
        }
      ],
      'name':'swapTokensForExactTokens',
      'outputs':<Map<String, String>>[
        <String, String>{
          'internalType':'uint256',
          'name':'amountIn',
          'type':'uint256'
        }
      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'token',
          'type':'address'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'amountMinimum',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'address',
          'name':'recipient',
          'type':'address'
        }
      ],
      'name':'sweepToken',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'token',
          'type':'address'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'amountMinimum',
          'type':'uint256'
        }
      ],
      'name':'sweepToken',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'token',
          'type':'address'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'amountMinimum',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'feeBips',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'address',
          'name':'feeRecipient',
          'type':'address'
        }
      ],
      'name':'sweepTokenWithFee',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'address',
          'name':'token',
          'type':'address'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'amountMinimum',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'address',
          'name':'recipient',
          'type':'address'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'feeBips',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'address',
          'name':'feeRecipient',
          'type':'address'
        }
      ],
      'name':'sweepTokenWithFee',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'int256',
          'name':'amount0Delta',
          'type':'int256'
        },
        <String, String>{
          'internalType':'int256',
          'name':'amount1Delta',
          'type':'int256'
        },
        <String, String>{
          'internalType':'bytes',
          'name':'_data',
          'type':'bytes'
        }
      ],
      'name':'uniswapV3SwapCallback',
      'outputs':<dynamic>[

      ],
      'stateMutability':'nonpayable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'uint256',
          'name':'amountMinimum',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'address',
          'name':'recipient',
          'type':'address'
        }
      ],
      'name':'unwrapWETH9',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'uint256',
          'name':'amountMinimum',
          'type':'uint256'
        }
      ],
      'name':'unwrapWETH9',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'uint256',
          'name':'amountMinimum',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'address',
          'name':'recipient',
          'type':'address'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'feeBips',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'address',
          'name':'feeRecipient',
          'type':'address'
        }
      ],
      'name':'unwrapWETH9WithFee',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'uint256',
          'name':'amountMinimum',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'uint256',
          'name':'feeBips',
          'type':'uint256'
        },
        <String, String>{
          'internalType':'address',
          'name':'feeRecipient',
          'type':'address'
        }
      ],
      'name':'unwrapWETH9WithFee',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    },
    <String, Object>{
      'inputs':<Map<String, String>>[
        <String, String>{
          'internalType':'uint256',
          'name':'value',
          'type':'uint256'
        }
      ],
      'name':'wrapETH',
      'outputs':<dynamic>[

      ],
      'stateMutability':'payable',
      'type':'function'
    }
  ];

  static List<Map<String, Object>> tether = <Map<String, Object>>[
    <String, Object>{
      'constant': true,
      'inputs': <dynamic>[],
      'name': 'name',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'string'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': false,
      'inputs': <Map<String, String>>[
        <String, String>{'name': '_upgradedAddress', 'type': 'address'}
      ],
      'name': 'deprecate',
      'outputs': <dynamic>[],
      'payable': false,
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'constant': false,
      'inputs': <Map<String, String>>[
        <String, String>{'name': '_spender', 'type': 'address'},
        <String, String>{'name': '_value', 'type': 'uint256'}
      ],
      'name': 'approve',
      'outputs': <dynamic>[],
      'payable': false,
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <dynamic>[],
      'name': 'deprecated',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'bool'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': false,
      'inputs': <Map<String, String>>[
        <String, String>{'name': '_evilUser', 'type': 'address'}
      ],
      'name': 'addBlackList',
      'outputs': <dynamic>[],
      'payable': false,
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <dynamic>[],
      'name': 'totalSupply',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'uint256'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': false,
      'inputs': <Map<String, String>>[
        <String, String>{'name': '_from', 'type': 'address'},
        <String, String>{'name': '_to', 'type': 'address'},
        <String, String>{'name': '_value', 'type': 'uint256'}
      ],
      'name': 'transferFrom',
      'outputs': <dynamic>[],
      'payable': false,
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <dynamic>[],
      'name': 'upgradedAddress',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'address'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'address'}
      ],
      'name': 'balances',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'uint256'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <dynamic>[],
      'name': 'decimals',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'uint256'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <dynamic>[],
      'name': 'maximumFee',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'uint256'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <dynamic>[],
      'name': '_totalSupply',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'uint256'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': false,
      'inputs': <dynamic>[],
      'name': 'unpause',
      'outputs': <dynamic>[],
      'payable': false,
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <Map<String, String>>[
        <String, String>{'name': '_maker', 'type': 'address'}
      ],
      'name': 'getBlackListStatus',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'bool'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'address'},
        <String, String>{'name': '', 'type': 'address'}
      ],
      'name': 'allowed',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'uint256'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <dynamic>[],
      'name': 'paused',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'bool'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <Map<String, String>>[
        <String, String>{'name': 'who', 'type': 'address'}
      ],
      'name': 'balanceOf',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'uint256'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': false,
      'inputs': <dynamic>[],
      'name': 'pause',
      'outputs': <dynamic>[],
      'payable': false,
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <dynamic>[],
      'name': 'getOwner',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'address'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <dynamic>[],
      'name': 'owner',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'address'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <dynamic>[],
      'name': 'symbol',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'string'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': false,
      'inputs': <Map<String, String>>[
        <String, String>{'name': '_to', 'type': 'address'},
        <String, String>{'name': '_value', 'type': 'uint256'}
      ],
      'name': 'transfer',
      'outputs': <dynamic>[],
      'payable': false,
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'constant': false,
      'inputs': <Map<String, String>>[
        <String, String>{'name': 'newBasisPoints', 'type': 'uint256'},
        <String, String>{'name': 'newMaxFee', 'type': 'uint256'}
      ],
      'name': 'setParams',
      'outputs': <dynamic>[],
      'payable': false,
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'constant': false,
      'inputs': <Map<String, String>>[
        <String, String>{'name': 'amount', 'type': 'uint256'}
      ],
      'name': 'issue',
      'outputs': <dynamic>[],
      'payable': false,
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'constant': false,
      'inputs': <Map<String, String>>[
        <String, String>{'name': 'amount', 'type': 'uint256'}
      ],
      'name': 'redeem',
      'outputs': <dynamic>[],
      'payable': false,
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <Map<String, String>>[
        <String, String>{'name': '_owner', 'type': 'address'},
        <String, String>{'name': '_spender', 'type': 'address'}
      ],
      'name': 'allowance',
      'outputs': <Map<String, String>>[
        <String, String>{'name': 'remaining', 'type': 'uint256'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <dynamic>[],
      'name': 'basisPointsRate',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'uint256'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'address'}
      ],
      'name': 'isBlackListed',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'bool'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': false,
      'inputs': <Map<String, String>>[
        <String, String>{'name': '_clearedUser', 'type': 'address'}
      ],
      'name': 'removeBlackList',
      'outputs': <dynamic>[],
      'payable': false,
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'constant': true,
      'inputs': <dynamic>[],
      'name': 'MAX_UINT',
      'outputs': <Map<String, String>>[
        <String, String>{'name': '', 'type': 'uint256'}
      ],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    },
    <String, Object>{
      'constant': false,
      'inputs': <Map<String, String>>[
        <String, String>{'name': 'newOwner', 'type': 'address'}
      ],
      'name': 'transferOwnership',
      'outputs': <dynamic>[],
      'payable': false,
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'constant': false,
      'inputs': <Map<String, String>>[
        <String, String>{'name': '_blackListedUser', 'type': 'address'}
      ],
      'name': 'destroyBlackFunds',
      'outputs': <dynamic>[],
      'payable': false,
      'stateMutability': 'nonpayable',
      'type': 'function'
    },
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{'name': '_initialSupply', 'type': 'uint256'},
        <String, String>{'name': '_name', 'type': 'string'},
        <String, String>{'name': '_symbol', 'type': 'string'},
        <String, String>{'name': '_decimals', 'type': 'uint256'}
      ],
      'payable': false,
      'stateMutability': 'nonpayable',
      'type': 'constructor'
    },
    <String, Object>{
      'anonymous': false,
      'inputs': <Map<String, Object>>[
        <String, Object>{'indexed': false, 'name': 'amount', 'type': 'uint256'}
      ],
      'name': 'Issue',
      'type': 'event'
    },
    <String, Object>{
      'anonymous': false,
      'inputs': <Map<String, Object>>[
        <String, Object>{'indexed': false, 'name': 'amount', 'type': 'uint256'}
      ],
      'name': 'Redeem',
      'type': 'event'
    },
    <String, Object>{
      'anonymous': false,
      'inputs': <Map<String, Object>>[
        <String, Object>{'indexed': false, 'name': 'newAddress', 'type': 'address'}
      ],
      'name': 'Deprecate',
      'type': 'event'
    },
    <String, Object>{
      'anonymous': false,
      'inputs': <Map<String, Object>>[
        <String, Object>{'indexed': false, 'name': 'feeBasisPoints', 'type': 'uint256'},
        <String, Object>{'indexed': false, 'name': 'maxFee', 'type': 'uint256'}
      ],
      'name': 'Params',
      'type': 'event'
    },
    <String, Object>{
      'anonymous': false,
      'inputs': <Map<String, Object>>[
        <String, Object>{'indexed': false, 'name': '_blackListedUser', 'type': 'address'},
        <String, Object>{'indexed': false, 'name': '_balance', 'type': 'uint256'}
      ],
      'name': 'DestroyedBlackFunds',
      'type': 'event'
    },
    <String, Object>{
      'anonymous': false,
      'inputs': <Map<String, Object>>[
        <String, Object>{'indexed': false, 'name': '_user', 'type': 'address'}
      ],
      'name': 'AddedBlackList',
      'type': 'event'
    },
    <String, Object>{
      'anonymous': false,
      'inputs': <Map<String, Object>>[
        <String, Object>{'indexed': false, 'name': '_user', 'type': 'address'}
      ],
      'name': 'RemovedBlackList',
      'type': 'event'
    },
    <String, Object>{
      'anonymous': false,
      'inputs': <Map<String, Object>>[
        <String, Object>{'indexed': true, 'name': 'owner', 'type': 'address'},
        <String, Object>{'indexed': true, 'name': 'spender', 'type': 'address'},
        <String, Object>{'indexed': false, 'name': 'value', 'type': 'uint256'}
      ],
      'name': 'Approval',
      'type': 'event'
    },
    <String, Object>{
      'anonymous': false,
      'inputs': <Map<String, Object>>[
        <String, Object>{'indexed': true, 'name': 'from', 'type': 'address'},
        <String, Object>{'indexed': true, 'name': 'to', 'type': 'address'},
        <String, Object>{'indexed': false, 'name': 'value', 'type': 'uint256'}
      ],
      'name': 'Transfer',
      'type': 'event'
    },
    <String, Object>{'anonymous': false, 'inputs': <dynamic>[], 'name': 'Pause', 'type': 'event'},
    <String, Object>{'anonymous': false, 'inputs': <dynamic>[], 'name': 'Unpause', 'type': 'event'}
  ];

  static List<Map<String, Object>> sereshForwarder = <Map<String, Object>>[
    <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{
          'internalType': 'uint256',
          'name': '_chainId',
          'type': 'uint256'
        }
      ],
      'stateMutability': 'nonpayable',
      'type': 'constructor'
    }, <String, Object>{
      'inputs': <dynamic>[],
      'name': 'InvalidShortString',
      'type': 'error'
    }, <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{
          'internalType': 'string',
          'name': 'str',
          'type': 'string'
        }
      ],
      'name': 'StringTooLong',
      'type': 'error'
    }, <String, Object>{
      'anonymous': false,
      'inputs': <dynamic>[],
      'name': 'EIP712DomainChanged',
      'type': 'event'
    }, <String, Object>{
      'anonymous': false,
      'inputs': <Map<String, Object>>[
        <String, Object>{
          'indexed': true,
          'internalType': 'address',
          'name': 'previousOwner',
          'type': 'address'
        }, <String, Object>{
          'indexed': true,
          'internalType': 'address',
          'name': 'newOwner',
          'type': 'address'
        }
      ],
      'name': 'OwnershipTransferred',
      'type': 'event'
    }, <String, Object>{
      'inputs': <dynamic>[],
      'name': 'chainId',
      'outputs': <Map<String, String>>[
        <String, String>{
          'internalType': 'uint256',
          'name': '',
          'type': 'uint256'
        }
      ],
      'stateMutability': 'view',
      'type': 'function'
    }, <String, Object>{
      'inputs': <dynamic>[],
      'name': 'eip712Domain',
      'outputs': <Map<String, String>>[
        <String, String>{
          'internalType': 'bytes1',
          'name': 'fields',
          'type': 'bytes1'
        }, <String, String>{
          'internalType': 'string',
          'name': 'name',
          'type': 'string'
        }, <String, String>{
          'internalType': 'string',
          'name': 'version',
          'type': 'string'
        }, <String, String>{
          'internalType': 'uint256',
          'name': 'chainId',
          'type': 'uint256'
        }, <String, String>{
          'internalType': 'address',
          'name': 'verifyingContract',
          'type': 'address'
        }, <String, String>{
          'internalType': 'bytes32',
          'name': 'salt',
          'type': 'bytes32'
        }, <String, String>{
          'internalType': 'uint256[]',
          'name': 'extensions',
          'type': 'uint256[]'
        }
      ],
      'stateMutability': 'view',
      'type': 'function'
    }, <String, Object>{
      'inputs': <Map<String, Object>>[
        <String, Object>{
          'components': <Map<String, String>>[
            <String, String>{
              'internalType': 'address',
              'name': 'from',
              'type': 'address'
            }, <String, String>{
              'internalType': 'address',
              'name': 'to',
              'type': 'address'
            }, <String, String>{
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256'
            }, <String, String>{
              'internalType': 'uint256',
              'name': 'gas',
              'type': 'uint256'
            }, <String, String>{
              'internalType': 'uint256',
              'name': 'nonce',
              'type': 'uint256'
            }, <String, String>{
              'internalType': 'bytes',
              'name': 'data',
              'type': 'bytes'
            }
          ],
          'internalType': 'struct SereshForwarder.ForwardRequest',
          'name': 'req',
          'type': 'tuple'
        }, <String, String>{
          'internalType': 'bytes32',
          'name': 'sigR',
          'type': 'bytes32'
        }, <String, String>{
          'internalType': 'bytes32',
          'name': 'sigS',
          'type': 'bytes32'
        }, <String, String>{
          'internalType': 'uint8',
          'name': 'sigV',
          'type': 'uint8'
        }
      ],
      'name': 'execute',
      'outputs': <Map<String, String>>[
        <String, String>{
          'internalType': 'bool',
          'name': '',
          'type': 'bool'
        }, <String, String>{
          'internalType': 'bytes',
          'name': '',
          'type': 'bytes'
        }
      ],
      'stateMutability': 'payable',
      'type': 'function'
    }, <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{
          'internalType': 'address',
          'name': 'from',
          'type': 'address'
        }
      ],
      'name': 'getNonce',
      'outputs': <Map<String, String>>[
        <String, String>{
          'internalType': 'uint256',
          'name': '',
          'type': 'uint256'
        }
      ],
      'stateMutability': 'view',
      'type': 'function'
    }, <String, Object>{
      'inputs': <dynamic>[],
      'name': 'owner',
      'outputs': <Map<String, String>>[
        <String, String>{
          'internalType': 'address',
          'name': '',
          'type': 'address'
        }
      ],
      'stateMutability': 'view',
      'type': 'function'
    }, <String, Object>{
      'inputs': <dynamic>[],
      'name': 'renounceOwnership',
      'outputs': <dynamic>[],
      'stateMutability': 'nonpayable',
      'type': 'function'
    }, <String, Object>{
      'inputs': <Map<String, String>>[
        <String, String>{
          'internalType': 'address',
          'name': 'newOwner',
          'type': 'address'
        }
      ],
      'name': 'transferOwnership',
      'outputs': <dynamic>[],
      'stateMutability': 'nonpayable',
      'type': 'function'
    }, <String, Object>{
      'inputs': <Map<String, Object>>[
        <String, Object>{
          'components': <Map<String, String>>[
            <String, String>{
              'internalType': 'address',
              'name': 'from',
              'type': 'address'
            }, <String, String>{
              'internalType': 'address',
              'name': 'to',
              'type': 'address'
            }, <String, String>{
              'internalType': 'uint256',
              'name': 'value',
              'type': 'uint256'
            }, <String, String>{
              'internalType': 'uint256',
              'name': 'gas',
              'type': 'uint256'
            }, <String, String>{
              'internalType': 'uint256',
              'name': 'nonce',
              'type': 'uint256'
            }, <String, String>{
              'internalType': 'bytes',
              'name': 'data',
              'type': 'bytes'
            }
          ],
          'internalType': 'struct SereshForwarder.ForwardRequest',
          'name': 'req',
          'type': 'tuple'
        }, <String, String>{
          'internalType': 'bytes32',
          'name': 'sigR',
          'type': 'bytes32'
        }, <String, String>{
          'internalType': 'bytes32',
          'name': 'sigS',
          'type': 'bytes32'
        }, <String, String>{
          'internalType': 'uint8',
          'name': 'sigV',
          'type': 'uint8'
        }
      ],
      'name': 'verify',
      'outputs': <Map<String, String>>[
        <String, String>{
          'internalType': 'bool',
          'name': '',
          'type': 'bool'
        }
      ],
      'stateMutability': 'view',
      'type': 'function'
    }
  ];

  static List<Map<String, Object>> test = <Map<String, Object>>[
    <String, Object>{
      'name': 'test_function',
      'type': 'function',
      'inputs': <Map<String, Object>>[
        <String, String>{'name': 'address', 'type': 'address'},
        <String, String>{'name': 'bool', 'type': 'bool'},
        <String, String>{'name': 'bytes', 'type': 'bytes'},
        <String, String>{'name': 'dynamic_array', 'type': 'int256[]'},
        <String, String>{'name': 'nested_dynamic_array', 'type': 'int256[][]'},
        <String, String>{'name': 'int', 'type': 'int256'},
        <String, String>{'name': 'uint', 'type': 'uint256'},
        <String, String>{'name': 'static_array', 'type': 'int256[10]'},
        <String, String>{'name': 'nested_static_array', 'type': 'int256[3][3]'},
        <String, String>{'name': 'string', 'type': 'string'},
        <String, Object>{
          'name': 'tuple',
          'type': 'tuple',
          'components': <Map<String, Object>>[
            <String, String>{'name': 'address', 'type': 'address'},
            <String, String>{'name': 'bool', 'type': 'bool'},
            <String, String>{'name': 'bytes', 'type': 'bytes'},
            <String, String>{'name': 'dynamic_array', 'type': 'int256[]'},
            <String, String>{'name': 'nested_dynamic_array', 'type': 'int256[][]'},
            <String, String>{'name': 'int', 'type': 'int256'},
            <String, String>{'name': 'uint', 'type': 'uint256'},
            <String, String>{'name': 'static_array', 'type': 'int256[10]'},
            <String, String>{'name': 'nested_static_array', 'type': 'int256[3][3]'},
            <String, String>{'name': 'string', 'type': 'string'},
            <String, Object>{
              'name': 'nested_tuple',
              'type': 'tuple',
              'components': <Map<String, String>>[
                <String, String>{'name': 'address', 'type': 'address'},
                <String, String>{'name': 'bool', 'type': 'bool'},
                <String, String>{'name': 'bytes', 'type': 'bytes'},
                <String, String>{'name': 'dynamic_array', 'type': 'int256[]'},
                <String, String>{'name': 'nested_dynamic_array', 'type': 'int256[][]'},
                <String, String>{'name': 'int', 'type': 'int256'},
                <String, String>{'name': 'uint', 'type': 'uint256'},
                <String, String>{'name': 'static_array', 'type': 'int256[10]'},
                <String, String>{'name': 'nested_static_array', 'type': 'int256[3][3]'},
                <String, String>{'name': 'string', 'type': 'string'}
              ]
            }
          ]
        }
      ],
      'outputs': <dynamic>[]
    }
  ];
}
