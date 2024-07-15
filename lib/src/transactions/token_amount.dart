import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

/// A class representing an amount of a specific token
class TokenAmount extends Equatable {
  /// The denomination of the token
  final String denomination;

  /// The amount of the token
  final Decimal amount;

  /// Creates a new instance of [TokenAmount]
  const TokenAmount({
    required this.denomination,
    required this.amount,
  });

  /// Creates a new instance of [TokenAmount] from a BigInt amount
  TokenAmount.fromBigInt({
    required this.denomination,
    required BigInt amount,
  }) : amount = Decimal.parse(amount.toString());

  @override
  String toString() {
    if (denomination.isEmpty) {
      return amount.toString();
    } else {
      return '$amount $denomination';
    }
  }

  @override
  List<Object?> get props => <Object?>[denomination, amount];
}
