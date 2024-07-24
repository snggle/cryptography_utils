import 'package:cryptography_utils/src/encoder/protobuf/protobuf_any.dart';

/// [CosmosPublicKey] is the abstract class that wraps the public key type.
abstract class CosmosPublicKey extends ProtobufAny {
  /// Constructs an [CosmosPublicKey]
  const CosmosPublicKey({
    required super.typeUrl,
  });
}
