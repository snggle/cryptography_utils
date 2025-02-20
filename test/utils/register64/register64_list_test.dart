import 'package:cryptography_utils/src/utils/register64/register64_list.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// ignore_for_file: cascade_invocations
void main() {
  group('Tests for Register64List() constructor', () {
    test('Should [return correct length] when Register64List is created with given length', () {
      // Act
      Register64List actualRegister64List = Register64List(5);
      int actualLength = actualRegister64List.length;

      // Assert
      int expectedLength = 5;

      expect(actualLength, expectedLength);
    });
  });

  group('Tests for Register64List.from() constructor', () {
    test('Should [return correct length] when Register64List is created from a list of values', () {
      // Arrange
      List<List<int>> actualValuesList = <List<int>>[
        <int>[1, 2],
        <int>[3, 4],
        <int>[5, 6],
      ];

      // Act
      Register64List actualRegister64List = Register64List.from(actualValuesList);
      int actualLength = actualRegister64List.length;

      // Assert
      int expectedLength = 3;

      expect(actualLength, expectedLength);
    });
  });

  group('Tests for Register64List.setRange()', () {
    test('Should [set range of values correctly] when setRange() is called', () {
      // Arrange
      Register64List actualSourceRegister64List = Register64List.from(const <List<int>>[
        <int>[1, 2],
        <int>[3, 4],
        <int>[5, 6],
        <int>[7, 8],
      ]);

      // Act
      Register64List actualRegister64List = Register64List(4);
      actualRegister64List.setRange(1, 3, actualSourceRegister64List);

      // Assert
      Register64List expectedRegister64List = Register64List.from(const <List<int>>[
        <int>[0, 0],
        <int>[1, 2],
        <int>[3, 4],
        <int>[0, 0],
      ]);

      expect(actualRegister64List, expectedRegister64List);
    });
  });
}
