import 'dart:typed_data';

import 'package:equatable/equatable.dart';

/// This class represents ciphertext and encapsulates the raw encrypted bytes.
/// It is typically used to hold the output of an encryption operation.
class CipherText extends Equatable {
  final Uint8List uint8List;

  const CipherText(this.uint8List);

  @override
  List<Object> get props => <Object>[uint8List];
}
