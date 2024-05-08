// Class was shaped by the influence of several key sources including:
// "blockchain_utils" - Copyright (c) 2010 Mohsen
// https://github.com/mrtnetwork/blockchain_utils/.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
// of the Software, and to permit persons to whom the Software is furnished to do
// so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

/// Represents an Ethereum digital signature, encapsulating the typical components of an ECDSA signature used
/// in Ethereum transactions. Ethereum signatures consist of the values [r], [s], and [v], where [r] and [s]
/// are components of the signature itself, and [v] is the recovery ID, which can help in recovering the public
/// key that corresponds to the private key used to generate the signature.
class EthereumSignature extends Equatable {
  /// The standard length of Ethereum signatures, excluding the recovery ID.
  static const int ethSignatureLength = 64;

  /// The length of the recovery ID in an Ethereum signature.
  static const int ethSignatureRecoveryIdLength = 1;

  /// The [s] value of the ECDSA signature, representing one half of the digital signature.
  final BigInt s;

  /// The [r] value of the ECDSA signature, representing the other half of the digital signature.
  final BigInt r;

  /// The recovery ID ([_v]) that can be used to help recover the public key associated with the Ethereum address
  /// from which the signature was generated. It is usually one of two possible values (27 or 28), adjusted for
  /// chain-specific reasons in more recent Ethereum standards.
  final int _v;

  /// Constructs an instance of [EthereumSignature] with the specified [s], [r], and [v] components.
  const EthereumSignature({
    required this.s,
    required this.r,
    required int v,
  }) : _v = v;

  /// Constructs an instance of [EthereumSignature] from a byte array.
  factory EthereumSignature.fromBytes(List<int> bytes) {
    if (bytes.length != ethSignatureLength && bytes.length != ethSignatureLength + ethSignatureRecoveryIdLength) {
      throw const FormatException('Invalid signature bytes');
    }
    List<int> rBytes = bytes.sublist(0, Curves.secp256k1.baselen);
    List<int> sBytes = bytes.sublist(Curves.secp256k1.baselen, Curves.secp256k1.baselen * 2);

    int v;
    if (bytes.length == ethSignatureLength) {
      v = (sBytes[0] & 0x80) != 0 ? 28 : 27;
      sBytes[0] &= 0x7f;
    } else {
      v = _getSignatureV(bytes[ethSignatureLength]);
    }

    final BigInt r = BigIntUtils.decode(rBytes);
    final BigInt s = BigIntUtils.decode(sBytes);
    return EthereumSignature(s: s, r: r, v: v);
  }

  /// Gets the recovery id from the [v] component.
  static int _getSignatureV(int v) {
    if (v == 0 || v == 27) {
      return 27;
    }
    if (v == 1 || v == 28) {
      return 28;
    }
    if (v < 35) {
      throw const FormatException('Invalid signature recovery id');
    }
    return (v & 1) != 0 ? 27 : 28;
  }

  /// Gets the byte representation of the 'r', 's', and 'v' components.
  Uint8List toBytes({bool eip155Bool = true}) {
    return Uint8List.fromList(<int>[...rBytes, ...sBytes, getV(eip155Bool: eip155Bool)]);
  }

  /// Gets the recovery ID from the signature.
  int getV({bool eip155Bool = true}) {
    return eip155Bool ? _v : _v - 27;
  }

  /// Gets the [r] component as a byte array.
  Uint8List get rBytes => BigIntUtils.changeToBytes(r, length: Curves.secp256k1.baselen);

  /// Gets the [s] component as a byte array.
  Uint8List get sBytes => BigIntUtils.changeToBytes(s, length: Curves.secp256k1.baselen);

  @override
  List<Object?> get props => <Object?>[s, r, _v];
}
