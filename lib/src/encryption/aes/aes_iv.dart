import 'dart:typed_data';

import 'package:equatable/equatable.dart';

/// Represents the initialization vector (IV) used in AES encryption.
/// Ensures input randomness and uniqueness for secure encryption.
class AESIV extends Equatable {
  final Uint8List uint8List;

  const AESIV(this.uint8List);

  @override
  List<Object> get props => <Object>[uint8List];
}
