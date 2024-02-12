import 'package:equatable/equatable.dart';

/// [EDCurve] represents an Edwards curve used in elliptic curve cryptography (ECC).
/// Edwards curves offer several advantages over other curve types, including faster arithmetic operations
/// and strong security properties, making them suitable for a wide range of cryptographic applications.

/// In ECC, an [EDCurve] is characterized by its equation, typically of the form x^2 + y^2 = 1 + dx^2y^2 in a finite field.
/// This equation defines the mathematical structure of the Edwards curve, where 'd' is a non-square element in the field,
/// and the curve parameters are chosen to optimize security and performance.

/// The curve is used to generate public-private key pairs and to perform operations like digital signatures.
/// It operates in a finite field, meaning that the values of the points on the curve are limited to a fixed range.
class EDCurve extends Equatable {
  /// A constant in the elliptic curve equation.
  /// Determines the specific curve used and impacts the cryptographic problem's difficulty.
  final BigInt a;

  /// A constant in the edward curve equation.
  /// Defines the curve's shape crucial for ECDSA cryptographic properties.
  final BigInt d;

  /// The cofactor of the edward curve, related to the curve's point count,
  /// used in calculations for subgroup security enhancement.
  final BigInt h;

  /// The prime number that defines the field over which the elliptic curve is defined,
  /// crucial for modulo operations in ECDSA.
  final BigInt p;

  const EDCurve({
    required this.a,
    required this.d,
    required this.h,
    required this.p,
  });

  @override
  List<Object?> get props => <Object>[a, d, h, p];
}
