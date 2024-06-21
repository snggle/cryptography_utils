import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

class TokenAmount extends Equatable {
  final String denomination;
  final Decimal amount;

  const TokenAmount({
    required this.denomination,
    required this.amount,
  });

  TokenAmount.fromBigInt({
    required this.denomination,
    required BigInt amount,
  }) : amount = Decimal.parse(amount.toString());

  @override
  String toString() {
    return '$amount $denomination';
  }

  @override
  List<Object?> get props => <Object?>[denomination, amount];
}
