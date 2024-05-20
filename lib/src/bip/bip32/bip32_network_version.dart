class Bip32NetworkVersion {
  /// The mainnet key net versions.
  static const Bip32NetworkVersion mainnet = Bip32NetworkVersion(
    public: <int>[0x04, 0x88, 0xb2, 0x1e],
    private: <int>[0x04, 0x88, 0xad, 0xe4],
  );

  /// The testnet key net versions.
  static const Bip32NetworkVersion testnet = Bip32NetworkVersion(
    public: <int>[0x04, 0x35, 0x87, 0xcf],
    private: <int>[0x04, 0x35, 0x83, 0x94],
  );

  /// The private key net version bytes.
  final List<int> private;

  /// The public key net version bytes.
  final List<int> public;

  /// Creates a new Bip32KeyNetVersions instance.
  const Bip32NetworkVersion({
    required this.private,
    required this.public,
  });
}
