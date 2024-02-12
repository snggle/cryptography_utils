// Class was shaped by the influence of several key sources including:
// "strobe" Copyright (C) 2023 - Kawaljeet Singh
// https://github.com/justkawal/strobe
//
// The MIT License (MIT)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
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

import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/big_int_utils.dart';
import 'package:equatable/equatable.dart';

/// The [Strobe] class is part of a lightweight, flexible framework designed for creating
/// cryptographic protocols. It leverages a sponge construction to support a variety of
/// operations like encryption, hashing, and more, within a unified interface.
class Strobe with EquatableMixin {
  /// The size of the authentication tag used in MAC functions
  static const int macLength = 16;

  /// The size of the nonce used in the Strobe protocol
  static List<int> strobeVersionTag = <int>[1, 0, 1, 0, 1, 96, 83, 84, 82, 79, 66, 69, 118, 49, 46, 48, 46, 50];

  /// Available flags
  static final Map<String, int> _operationMap = <String, int>{
    'AD': StrobeFlag.flagA.bit,
    'KEY': StrobeFlag.flagA.bit | StrobeFlag.flagC.bit,
    'PRF': StrobeFlag.flagI.bit | StrobeFlag.flagA.bit | StrobeFlag.flagC.bit,
    'send_CLR': StrobeFlag.flagA.bit | StrobeFlag.flagT.bit,
    'recv_CLR': StrobeFlag.flagI.bit | StrobeFlag.flagA.bit | StrobeFlag.flagT.bit,
    'send_ENC': StrobeFlag.flagA.bit | StrobeFlag.flagC.bit | StrobeFlag.flagT.bit,
    'recv_ENC': StrobeFlag.flagI.bit | StrobeFlag.flagA.bit | StrobeFlag.flagC.bit | StrobeFlag.flagT.bit,
    'send_MAC': StrobeFlag.flagC.bit | StrobeFlag.flagT.bit,
    'recv_MAC': StrobeFlag.flagI.bit | StrobeFlag.flagC.bit | StrobeFlag.flagT.bit,
    'RATCHET': StrobeFlag.flagC.bit,
  };

  /// The rate of duplex operation, defining the amount of data processed per block.
  final int _duplexRate;

  /// The rate at which the STROBE protocol operates, related to the sponge's absorption rate.
  final int _strobeRate;

  /// Buffer for data to be XORed, optimizing cryptographic operations.
  final List<int> _storage;

  /// Temporary buffer for holding the state during operations.
  final Uint8List _tempStateBuffer;

  /// Defines the role of the STROBE instance in the communication (e.g., sender or receiver).
  late StrobeRole _role;

  /// The actual state
  final List<BigInt> _actualState;

  /// Used to avoid padding during the first permutation
  late bool _initializedBool;

  /// Marks the start of the current operation within the buffer.
  /// A value of 0 indicates the previous block.
  late int _positionBegin;

  /// Flags representing the current operational state or mode of the STROBE protocol.
  late int _currentFlags;

  /// A pointer into the storage
  late List<int> _buffer;

  Strobe({
    required int duplexRate,
    required int strobeRate,
    required List<int> storage,
    required Uint8List tempStateBuffer,
    required StrobeRole role,
    required List<BigInt> actualState,
    required bool initializedBool,
    required int positionBegin,
    required int currentFlags,
    required List<int> buffer,
  })  : _duplexRate = duplexRate,
        _strobeRate = strobeRate,
        _storage = storage,
        _tempStateBuffer = tempStateBuffer,
        _role = role,
        _actualState = actualState,
        _initializedBool = initializedBool,
        _positionBegin = positionBegin,
        _currentFlags = currentFlags,
        _buffer = buffer;

  Strobe._({
    required int duplexRate,
  })  : _duplexRate = duplexRate,
        _strobeRate = duplexRate - 2,
        _storage = Uint8List(duplexRate),
        _tempStateBuffer = Uint8List(duplexRate),
        _actualState = List<BigInt>.generate(25, (_) => BigInt.zero),
        _role = StrobeRole.iNone,
        _initializedBool = false,
        _buffer = <int>[];

  /// Creates a new Strobe protocol instance, allowing for customization through a user-defined string and the selection of a security level target,
  /// typically either 128 or 256 bits. The customization string can be used to differentiate instances or protocols and can be empty if not needed.
  static Strobe initStrobe(String customizationString, StrobeSecurityLevel securityLevel) {
    Strobe strobe = Strobe._(duplexRate: 1600 ~/ 8 - (securityLevel.bit) ~/ 4);

    Uint8List domain = Uint8List(18)..setAll(0, strobeVersionTag);
    domain[1] = (strobe._strobeRate + 2) & 0xFF;
    strobe
      .._performDuplexOperation(domain, cBefore: false, cAfter: false, forceF: true)
      .._initializedBool = true
      .._operate('AD', utf8.encode(customizationString), 0, metaBool: true, moreBool: false);

    return strobe;
  }

  /// Authenticates Additional Data (AD) within the current cryptographic operation.
  /// This method allows the inclusion of non-encrypted (plain) data to be authenticated
  /// along with the encrypted message. It is crucial for ensuring the integrity and authenticity
  /// of such data. For the authentication to be effective, this method should be followed
  /// by either a `Send_MAC` or `Recv_MAC` operation.
  void authenticateAdditionalData(List<int> additionalData, {required bool metaBool}) {
    _operate('AD', additionalData, 0, metaBool: metaBool, moreBool: false);
  }

  /// Generates a Pseudo-Random Function (PRF) output based on the current state.
  /// This method produces a hash or a sequence of pseudo-random bytes of a specified
  /// length from the current state of the Strobe instance
  Uint8List prf(int outputLen) {
    return _operate('PRF', Uint8List(0), outputLen, metaBool: false, moreBool: false);
  }

  /// Executes a specified operation within the Strobe protocol.
  ///
  /// This method is a general-purpose operation executor that can handle a variety
  /// of operations defined in the [_operationMap]. Depending on the operation,
  /// it can either use the provided [dataConst] along with [length] for operations
  /// requiring data, or just [length] for operations that don't.
  Uint8List _operate(String operation, List<int> dataConst, int length, {required bool moreBool, required bool metaBool}) {
    late int flags;
    if (_operationMap.containsKey(operation)) {
      flags = _operationMap[operation]!;
    } else {
      throw Exception('Not a valid operation');
    }

    if (metaBool) {
      flags |= StrobeFlag.flagM.bit;
    }

    late Uint8List data;

    if (((flags & (StrobeFlag.flagI.bit | StrobeFlag.flagT.bit)) != (StrobeFlag.flagI.bit | StrobeFlag.flagT.bit)) &&
        ((flags & (StrobeFlag.flagI.bit | StrobeFlag.flagA.bit)) != StrobeFlag.flagA.bit)) {
      if (length == 0) {
        throw Exception('A length should be set for this operation.');
      }
      data = Uint8List(length);
    } else {
      if (length != 0) {
        throw Exception('Output length must be zero except for PRF, send_MAC, and RATCHET operations.');
      }
      data = Uint8List.fromList(dataConst);
    }

    if (moreBool) {
      if (flags != _currentFlags) {
        throw Exception('Flag should be the same when streaming operations.');
      }
    } else {
      _beginOperation(flags);
      _currentFlags = flags;
    }

    bool cAfter = (flags & (StrobeFlag.flagC.bit | StrobeFlag.flagI.bit | StrobeFlag.flagT.bit)) == (StrobeFlag.flagC.bit | StrobeFlag.flagT.bit);
    bool cBefore = (flags & StrobeFlag.flagC.bit != 0) && (!cAfter);

    _performDuplexOperation(data, cBefore: cBefore, cAfter: cAfter, forceF: false);

    if ((flags & (StrobeFlag.flagI.bit | StrobeFlag.flagA.bit)) == (StrobeFlag.flagI.bit | StrobeFlag.flagA.bit)) {
      return data;
    } else if ((flags & (StrobeFlag.flagI.bit | StrobeFlag.flagT.bit)) == StrobeFlag.flagT.bit) {
      return data;
    } else if ((flags & (StrobeFlag.flagI.bit | StrobeFlag.flagA.bit | StrobeFlag.flagT.bit)) == (StrobeFlag.flagI.bit | StrobeFlag.flagT.bit)) {
      if (moreBool) {
        throw Exception("Not supposed to check a MAC with the 'moreBool' streaming option");
      }
      int failures = 0;
      for (int dataByte in data) {
        failures |= dataByte;
      }
      Uint8List result = Uint8List(1);
      result[0] = failures;
      return result;
    }

    return Uint8List(0);
  }

  /// Initializes the beginning of a cryptographic operation with specified flags.
  /// This method sets up the context for a new operation within the Strobe protocol,
  /// configuring it with a set of flags that determine the operation's behavior and
  /// characteristics. It is typically called internally to prepare the state for
  /// subsequent cryptographic processing.
  void _beginOperation(int flags) {
    int tempFlags = flags;
    if (flags & StrobeFlag.flagT.bit != 0) {
      if (_role.index == StrobeRole.iNone.index) {
        _role = StrobeRole.values[tempFlags & StrobeFlag.flagI.bit];
      }
      tempFlags ^= StrobeFlag.values[_role.index].index;
    }

    int oldBegin = _positionBegin;
    _positionBegin = (_buffer.length + 1).toUnsigned(8); // s.pos + 1
    bool forceF = (tempFlags & (StrobeFlag.flagC.bit | StrobeFlag.flagK.bit) != 0);
    _performDuplexOperation(Uint8List.fromList(<int>[oldBegin, tempFlags & 0xFF]), cBefore: false, cAfter: false, forceF: forceF);
  }

  /// Performs a duplex operation on provided data with specific control flags.
  /// This method is a core part of the Strobe protocol's duplex cryptographic mechanism
  void _performDuplexOperation(Uint8List data, {required bool cBefore, required bool cAfter, required bool forceF}) {
    int currentIndex = 0;

    // Process data block by block
    while (currentIndex < data.length) {
      int todo = _strobeRate - _buffer.length;
      if (todo > data.length - currentIndex) {
        todo = data.length - currentIndex;
      }

      if (cBefore) {
        _outputState(_actualState, _tempStateBuffer);
        for (int idx = currentIndex; idx < currentIndex + todo; idx++) {
          data[idx] ^= _tempStateBuffer[_buffer.length + idx - currentIndex];
        }
      }

      // Buffer what's to be XOR'ed (we XOR once during runF)
      _buffer.addAll(data.sublist(currentIndex, currentIndex + todo));
      _storage.setAll(0, _buffer);

      if (cAfter) {
        _outputState(_actualState, _tempStateBuffer);
        for (int idx = currentIndex; idx < currentIndex + todo; idx++) {
          data[idx] ^= _tempStateBuffer[_buffer.length - todo + idx - currentIndex];
        }
      }

      currentIndex += todo;

      // If the duplex is full, it's time to XOR + pad + permute.
      if (_buffer.length == _strobeRate) {
        _runF();
      }
    }

    // Sometimes we want the next operation to start on a new block
    if (forceF && _buffer.isNotEmpty) {
      _runF();
    }
  }

  /// This method is used to extract a portion of the internal state of the Strobe
  /// protocol into a given buffer. It is specifically designed to work with buffers that are 8-byte aligned
  void _outputState(List<BigInt> state, Uint8List b) {
    int n = b.length ~/ 8;
    for (int i = 0; i < n; i++) {
      Uint8List bytes = BigIntUtils.changeToBytes(state[i], order: Endian.little);
      b.setAll(i * 8, bytes.toList());
    }
  }

  /// Executes the STROBE protocol's permutation operation with padding.
  /// This method applies the necessary padding as defined by both the STROBE
  /// and cSHAKE specifications, followed by the execution of the Keccak permutation.
  void _runF() {
    if (_initializedBool) {
      // If initialized, apply Strobe padding
      if (_buffer.length > _strobeRate) {
        throw Exception('Strobe: Buffer is never supposed to reach _strobeRate');
      }
      _buffer.add(_positionBegin);
      _storage[_buffer.length - 1] = _positionBegin;
      _buffer.add(0x04);
      _storage[_buffer.length - 1] = 0x04;
      _buffer.addAll(Uint8List(_duplexRate - _buffer.length));
      _buffer[_duplexRate - 1] ^= 0x80;
      _storage[_duplexRate - 1] ^= 0x80;
      _xorState(_actualState, _buffer);
    } else if (_buffer.isNotEmpty) {
      // If not initialized, pad with zeros for xorState to work
      // rate = [0--end_of_buffer/zeroStart---duplexRate]
      _buffer = List<int>.from(_storage.sublist(0, _duplexRate));
      for (int i = _buffer.length; i < _duplexRate; i++) {
        _buffer[i] = 0;
      }
      _xorState(_actualState, _buffer);
    }

    // Run the permutation
    KeccakF1600(24).process(_actualState);

    // Reset the buffer and set posBegin to 0
    // (meaning that the current operation started on a previous block)
    _buffer.clear();
    _positionBegin = 0;
  }

  /// Performs an XOR operation between the internal state and a buffer.
  /// This method applies an XOR operation to each element of the internal state with corresponding bytes from the provided buffer.
  void _xorState(List<BigInt> state, List<int> buf) {
    int n = buf.length ~/ 8;
    for (int i = 0; i < n; i++) {
      BigInt a = BigIntUtils.decode(buf.sublist(i * 8, (i + 1) * 8), order: Endian.little);
      state[i] ^= a;
    }
  }

  @override
  List<Object?> get props => <Object>[_duplexRate, _strobeRate, _storage, _buffer, _tempStateBuffer, _role, _actualState, _positionBegin, _currentFlags];

  @override
  String toString() {
    return 'Strobe {\n'
        '  _duplexRate: $_duplexRate,\n'
        '  _strobeRate: $_strobeRate,\n'
        '  _storage: ${base64Encode(_storage)},\n'
        '  _tempStateBuffer: ${base64Encode(_tempStateBuffer)},\n'
        '  _role: $_role,\n'
        '  _actualState: $_actualState,\n'
        '  _initializedBool: $_initializedBool,\n'
        '  _positionBegin: $_positionBegin,\n'
        '  _currentFlags: $_currentFlags\n'
        '  _buffer: ${base64Encode(_buffer)},\n'
        '}';
  }
}
