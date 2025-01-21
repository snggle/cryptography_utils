enum KeccakBitLength {
  keccak128(128),
  keccak224(224),
  keccak256(256),
  keccak288(288),
  keccak384(384),
  keccak512(512);

  final int bitLength;

  const KeccakBitLength(this.bitLength);
}
