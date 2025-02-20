// This class was primarily influenced by:
// "pointycastle" - Copyright (c) 2000 - 2019 The Legion of the Bouncy Castle Inc. (https://www.bouncycastle.org)
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

import 'dart:core';

import 'package:cryptography_utils/src/utils/register64/register64.dart';
import 'package:equatable/equatable.dart';

/// [Register64List] manages a list of 64-bit registers for the algorithm's internal state.
class Register64List extends Equatable {
  final List<Register64> _register64List;

  Register64List(int listLength) : _register64List = List<Register64>.generate(listLength, (_) => Register64(0, 0));

  Register64List.from(List<List<int>> valuesList)
      : _register64List = List<Register64>.generate(
          valuesList.length,
          (int i) => Register64(valuesList[i][0], valuesList[i][1]),
        );

  int get length => _register64List.length;

  Register64 operator [](int index) => _register64List[index];

  void setRange(int start, int end, Register64List register64List, [int skipCount = 0]) {
    int length = end - start;
    for (int i = 0; i < length; i++) {
      _register64List[start + i].setRegister64(register64List[skipCount + i]);
    }
  }

  @override
  List<List<Register64>> get props => <List<Register64>>[_register64List];
}
