enum SignDataType {
  /// For signing message usage, like EIP-191 personal sign data
  rawBytes,

  /// EIP-2718 typed transaction of unsigned transaction data
  typedTransaction,
}
