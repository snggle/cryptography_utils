import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/string_utils.dart';

class EthereumRawTransaction extends AEthereumTransaction {
  final Uint8List data;

  const EthereumRawTransaction({
    required this.data,
  });

  @override
  factory EthereumRawTransaction.fromSerializedData(Uint8List data) {
    return EthereumRawTransaction(data: data);
  }

  @override
  Uint8List serialize() {
    return Uint8List.fromList(data);
  }

  @override
  String get message {
    if (StringUtils.isASCIIBytes(data)) {
      return ascii.decode(data);
    } else {
      return HexEncoder.encode(data);
    }
  }

  @override
  List<Object?> get props => <Object>[data];
}
