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
}
