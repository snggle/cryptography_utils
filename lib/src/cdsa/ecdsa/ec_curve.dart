import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

/// `ECCurve` represents an elliptic curve used in elliptic curve cryptography (ECC).
/// It defines the mathematical structure of the curve over which cryptographic operations are performed.
///
/// In ECC, an `ECCurve` is characterized by its equation, typically of the form y^2 = x^3 + ax + b in a finite field.
/// The choice of the curve, defined by its parameters, impacts the security and efficiency of the cryptographic algorithm.
///
/// The curve is used to generate public-private key pairs and to perform operations like digital signatures.
/// It operates in a finite field, meaning that the values of the points on the curve are limited to a fixed range.
class ECCurve extends Equatable {
  /// A constant in the elliptic curve equation.
  /// Determines the specific curve used and impacts the cryptographic problem's difficulty.
  final BigInt a;

  /// A constant in the elliptic curve equation.
  /// Defines the curve's shape crucial for ECDSA cryptographic properties.
  final BigInt b;

  /// The cofactor of the elliptic curve, related to the curve's point count,
  /// used in calculations for subgroup security enhancement.
  final BigInt h;

  /// The prime number that defines the field over which the elliptic curve is defined,
  /// crucial for modulo operations in ECDSA.
  final BigInt p;

  const ECCurve({
    required this.a,
    required this.b,
    required this.h,
    required this.p,
  });

  int get baselen => BigIntUtils.calculateByteLength(p);

  @override
  List<Object?> get props => <Object>[a, b, h, p];
}
