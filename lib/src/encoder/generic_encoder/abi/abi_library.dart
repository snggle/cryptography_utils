class AbiLibrary {
  // static List<Map<String, Object>> test = <Map<String, Object>>[
  //   <String, Object>{ 'type': 'function', 'name': ''},
  //   <String, Object>{ 'type': 'function', 'name': 'balance', 'stateMutability': 'view'},
  //   <String, Object>{ 'type': 'function', 'name': 'send', 'inputs': <Map<String, String>>[ <String, String>{ 'name': 'amount', 'type': 'uint256'}]},
  //   <String, Object>{ 'type': 'function', 'name': 'test', 'inputs': <Map<String, String>>[ <String, String>{ 'name': 'number', 'type': 'uint32'}]},
  //   <String, Object>{ 'type': 'function', 'name': 'string', 'inputs': <Map<String, String>>[ <String, String>{ 'name': 'inputs', 'type': 'string'}]},
  //   <String, Object>{ 'type': 'function', 'name': 'bool', 'inputs': <Map<String, String>>[ <String, String>{ 'name': 'inputs', 'type': 'bool'}]},
  //   <String, Object>{ 'type': 'function', 'name': 'address', 'inputs': <Map<String, String>>[ <String, String>{ 'name': 'inputs', 'type': 'address'}]},
  //   <String, Object>{ 'type': 'function', 'name': 'uint64[2]', 'inputs': <Map<String, String>>[ <String, String>{ 'name': 'inputs', 'type': 'uint64[2]'}]},
  //   <String, Object>{ 'type': 'function', 'name': 'uint64[]', 'inputs': <Map<String, String>>[ <String, String>{ 'name': 'inputs', 'type': 'uint64[]'}]},
  //   <String, Object>{ 'type': 'function', 'name': 'int8', 'inputs': <Map<String, String>>[ <String, String>{ 'name': 'inputs', 'type': 'int8'}]},
  //   <String, Object>{ 'type': 'function', 'name': 'bytes32', 'inputs': <Map<String, String>>[ <String, String>{ 'name': 'inputs', 'type': 'bytes32'}]},
  //   <String, Object>{ 'type': 'function', 'name': 'foo', 'inputs': <Map<String, String>>[ <String, String>{ 'name': 'inputs', 'type': 'uint32'}]},
  //   <String, Object>{
  //     'type': 'function',
  //     'name': 'bar',
  //     'inputs': <Map<String, String>>[ <String, String>{ 'name': 'inputs', 'type': 'uint32'}, <String, String>{ 'name': 'string', 'type': 'uint16'}]
  //   },
  //   <String, Object>{ 'type': 'function', 'name': 'slice', 'inputs': <Map<String, String>>[ <String, String>{ 'name': 'inputs', 'type': 'uint32[2]'}]},
  //   <String, Object>{ 'type': 'function', 'name': 'slice256', 'inputs': <Map<String, String>>[ <String, String>{ 'name': 'inputs', 'type': 'uint256[2]'}]},
  //   <String, Object>{ 'type': 'function', 'name': 'sliceAddress', 'inputs': <Map<String, String>>[ <String, String>{ 'name': 'inputs', 'type': 'address[]'}]},
  //   <String, Object>{
  //     'type': 'function',
  //     'name': 'sliceMultiAddress',
  //     'inputs': <Map<String, String>>[ <String, String>{ 'name': 'a', 'type': 'address[]'}, <String, String>{ 'name': 'b', 'type': 'address[]'}]
  //   },
  //   <String, Object>{
  //     'type': 'function',
  //     'name': 'nestedArray',
  //     'inputs': <Map<String, String>>[ <String, String>{ 'name': 'a', 'type': 'uint256[2][2]'}, <String, String>{ 'name': 'b', 'type': 'address[]'}]
  //   },
  //   <String, Object>{ 'type': 'function', 'name': 'nestedArray2', 'inputs': <Map<String, String>>[ <String, String>{ 'name': 'a', 'type': 'uint8[][2]'}]},
  //   <String, Object>{ 'type': 'function', 'name': 'nestedSlice', 'inputs': <Map<String, String>>[ <String, String>{ 'name': 'a', 'type': 'uint8[][]'}]},
  //   <String, Object>{
  //     'type': 'function',
  //     'name': 'receive',
  //     'inputs': <Map<String, String>>[ <String, String>{ 'name': 'memo', 'type': 'bytes'}],
  //     'outputs': <>[],
  //     'payable': true,
  //     'stateMutability': 'payable'
  //   },
  //   <String, Object>{
  //     'type': 'function',
  //     'name': 'fixedArrStr',
  //     'stateMutability': 'view',
  //     'inputs': <Map<String, String>>[ <String, String>{ 'name': 'str', 'type': 'string'}, <String, String>{ 'name': 'fixedArr', 'type': 'uint256[2]'}]
  //   },
  //   <String, Object>{
  //     'type': 'function',
  //     'name': 'fixedArrBytes',
  //     'stateMutability': 'view',
  //     'inputs': <Map<String, String>>[ <String, String>{ 'name': 'bytes', 'type': 'bytes'}, <String, String>{ 'name': 'fixedArr', 'type': 'uint256[2]'}]
  //   },
  //   <String, Object>{
  //     'type': 'function',
  //     'name': 'mixedArrStr',
  //     'stateMutability': 'view',
  //     'inputs': <Map<String, String>>[
  //       <String, String>{ 'name': 'str', 'type': 'string'},
  //       <String, String>{ 'name': 'fixedArr', 'type': 'uint256[2]'},
  //       <String, String>{ 'name': 'dynArr', 'type': 'uint256[]'}
  //     ]
  //   },
  //   <String, Object>{
  //     'type': 'function',
  //     'name': 'doubleFixedArrStr',
  //     'stateMutability': 'view',
  //     'inputs': <Map<String, String>>[
  //       <String, String>{ 'name': 'str', 'type': 'string'},
  //       <String, String>{ 'name': 'fixedArr1', 'type': 'uint256[2]'},
  //       <String, String>{ 'name': 'fixedArr2', 'type': 'uint256[3]'}
  //     ]
  //   },
  //   <String, Object>{
  //     'type': 'function',
  //     'name': 'multipleMixedArrStr',
  //     'stateMutability': 'view',
  //     'inputs': <Map<String, String>>[
  //       <String, String>{ 'name': 'str', 'type': 'string'},
  //       <String, String>{ 'name': 'fixedArr1', 'type': 'uint256[2]'},
  //       <String, String>{ 'name': 'dynArr', 'type': 'uint256[]'},
  //       <String, String>{ 'name': 'fixedArr2', 'type': 'uint256[3]'}
  //     ]
  //   },
  //   <String, Object>{
  //     'type': 'function',
  //     'name': 'overloadedNames',
  //     'stateMutability': 'view',
  //     'inputs': <Map<String, Object>>[
  //       <String, Object>{
  //         'components': <Map<String, String>>[
  //           <String, String>{ 'internalType': 'uint256', 'name': '_f', 'type': 'uint256'},
  //           <String, String>{ 'internalType': 'uint256', 'name': '__f', 'type': 'uint256'},
  //           <String, String>{ 'internalType': 'uint256', 'name': 'f', 'type': 'uint256'}
  //         ],
  //         'internalType': 'struct Overloader.F',
  //         'name': 'f',
  //         'type': 'tuple'
  //       }
  //     ]
  //   }
  // ];

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

  static List<Map<String, Object>> uniswap = <Map<String, Object>>[
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
}
