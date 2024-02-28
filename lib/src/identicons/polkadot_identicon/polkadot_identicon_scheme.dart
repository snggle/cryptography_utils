import 'package:equatable/equatable.dart';

class PolkadotIdenticonScheme extends Equatable {
  static final List<PolkadotIdenticonScheme> schemes = <PolkadotIdenticonScheme>[target, cube, quazar, flower, cyclic, vmirror, hmirror];

  static const PolkadotIdenticonScheme target = PolkadotIdenticonScheme(
    colors: <int>[0, 28, 0, 0, 28, 0, 0, 28, 0, 0, 28, 0, 0, 28, 0, 0, 28, 0, 1],
    frequency: 1,
  );

  static const PolkadotIdenticonScheme cube = PolkadotIdenticonScheme(
    colors: <int>[0, 1, 3, 2, 4, 3, 0, 1, 3, 2, 4, 3, 0, 1, 3, 2, 4, 3, 5],
    frequency: 20,
  );

  static const PolkadotIdenticonScheme quazar = PolkadotIdenticonScheme(
    colors: <int>[1, 2, 3, 1, 2, 4, 5, 5, 4, 1, 2, 3, 1, 2, 4, 5, 5, 4, 0],
    frequency: 16,
  );

  static const PolkadotIdenticonScheme flower = PolkadotIdenticonScheme(
    colors: <int>[0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 3],
    frequency: 32,
  );

  static const PolkadotIdenticonScheme cyclic = PolkadotIdenticonScheme(
    colors: <int>[0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 6],
    frequency: 32,
  );

  static const PolkadotIdenticonScheme vmirror = PolkadotIdenticonScheme(
    colors: <int>[0, 1, 2, 3, 4, 5, 3, 4, 2, 0, 1, 6, 7, 8, 9, 7, 8, 6, 10],
    frequency: 128,
  );

  static const PolkadotIdenticonScheme hmirror = PolkadotIdenticonScheme(
    colors: <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 8, 6, 7, 5, 3, 4, 2, 11],
    frequency: 128,
  );

  final List<int> colors;
  final int frequency;

  const PolkadotIdenticonScheme({
    required this.colors,
    required this.frequency,
  });

  @override
  List<Object> get props => <Object>[colors, frequency];
}
