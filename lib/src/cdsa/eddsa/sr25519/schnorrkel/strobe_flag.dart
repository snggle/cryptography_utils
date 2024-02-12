/// Defines flags for controlling STROBE protocol operations.
///
/// This enum lists the flags used in the STROBE protocol to specify the behavior of
/// various cryptographic operations. Each flag is associated with a specific bit value.
enum StrobeFlag {
  flagI(1),
  flagA(2),
  flagC(4),
  flagT(8),
  flagM(16),
  flagK(32);

  final int bit;

  const StrobeFlag(this.bit);
}
