import 'package:codec_utils/codec_utils.dart';

/// [CosmosPublicKey] is the abstract class that wraps the public key type.
abstract class CosmosPublicKey extends ProtobufAny {
  /// Constructs a [CosmosPublicKey]
  const CosmosPublicKey({
    required super.typeUrl,
  });
}
