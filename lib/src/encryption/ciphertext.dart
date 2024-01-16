import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:cryptography_utils/src/utils/map_utils.dart';
import 'package:equatable/equatable.dart';

class Ciphertext extends Equatable {
  final EncryptionAlgorithmType encryptionAlgorithmType;
  final Uint8List bytes;

  Ciphertext({
    required List<int> bytes,
    required this.encryptionAlgorithmType,
  }) : bytes = Uint8List.fromList(bytes);

  Ciphertext.fromBase64({
    required String base64,
    required this.encryptionAlgorithmType,
  }) : bytes = base64Decode(base64);

  factory Ciphertext.deserialize(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString) as Map<String, dynamic>;
    return Ciphertext.fromJson(json);
  }

  factory Ciphertext.fromJson(Map<String, dynamic> json) {
    return Ciphertext(
      encryptionAlgorithmType: EncryptionAlgorithmType.fromString(json['algorithm'] as String),
      bytes: base64Decode(json['data'] as String),
    );
  }

  String serialize({required bool prettyPrintBool}) {
    return MapUtils.parseJsonToString(<String, dynamic>{
      'algorithm': encryptionAlgorithmType.name,
      'data': base64Encode(bytes),
    }, prettyPrintBool: prettyPrintBool);
  }

  String get base64 => base64Encode(bytes);

  @override
  List<Object?> get props => <Object>[bytes];
}
