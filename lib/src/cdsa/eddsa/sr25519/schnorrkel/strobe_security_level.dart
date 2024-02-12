/// Specifies the security levels supported by the STROBE protocol.
/// This enum defines the available security levels for operations using the STROBE protocol framework.
enum StrobeSecurityLevel {
  sec128(128),
  sec256(256);

  final int bit;

  const StrobeSecurityLevel(this.bit);
}
