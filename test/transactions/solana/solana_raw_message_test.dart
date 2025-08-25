import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/src/transactions/solana/solana_raw_message.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of SolanaRawMessage.fromSerializedData() constructor', () {
    test('Should [return SolanaRawMessage] from given bytes', () {
      // Arrange
      Uint8List actualBytes = base64Decode(
        'b3BlbnNlYS5pbyB3YW50cyB5b3UgdG8gc2lnbiBpbiB3aXRoIHlvdXIgYWNjb3VudDoKNlZXVXRRaUViU1h5NnZpWGt4czd4eXdldlFKWHJ1VkQxTm1oWDRha2RDMVoKCkNsaWNrIHRvIHNpZ24gaW4gYW5kIGFjY2VwdCB0aGUgT3BlblNlYSBUZXJtcyBvZiBTZXJ2aWNlIChodHRwczovL29wZW5zZWEuaW8vdG9zKSBhbmQgUHJpdmFjeSBQb2xpY3kgKGh0dHBzOi8vb3BlbnNlYS5pby9wcml2YWN5KS4KClVSSTogaHR0cHM6Ly9vcGVuc2VhLmlvLwpWZXJzaW9uOiAxCkNoYWluIElEOiAxCk5vbmNlOiBncThjcDI4aW5uODlyZ3ZhaG91c2QycXMzMwpJc3N1ZWQgQXQ6IDIwMjUtMDgtMjVUMTY6MjU6MzkuMzI5Wg==',
      );

      // Act
      SolanaRawMessage actualSolanaRawMessage = SolanaRawMessage.fromSerializedData(actualBytes);

      // Assert
      Uint8List expectedBytes = base64Decode(
        'b3BlbnNlYS5pbyB3YW50cyB5b3UgdG8gc2lnbiBpbiB3aXRoIHlvdXIgYWNjb3VudDoKNlZXVXRRaUViU1h5NnZpWGt4czd4eXdldlFKWHJ1VkQxTm1oWDRha2RDMVoKCkNsaWNrIHRvIHNpZ24gaW4gYW5kIGFjY2VwdCB0aGUgT3BlblNlYSBUZXJtcyBvZiBTZXJ2aWNlIChodHRwczovL29wZW5zZWEuaW8vdG9zKSBhbmQgUHJpdmFjeSBQb2xpY3kgKGh0dHBzOi8vb3BlbnNlYS5pby9wcml2YWN5KS4KClVSSTogaHR0cHM6Ly9vcGVuc2VhLmlvLwpWZXJzaW9uOiAxCkNoYWluIElEOiAxCk5vbmNlOiBncThjcDI4aW5uODlyZ3ZhaG91c2QycXMzMwpJc3N1ZWQgQXQ6IDIwMjUtMDgtMjVUMTY6MjU6MzkuMzI5Wg==',
      );

      expect(actualSolanaRawMessage.data, expectedBytes);
    });
  });

  group('Tests of SolanaRawMessage.serialize()', () {
    test('Should [return bytes] representing serialized transaction', () {
      // Arrange
      Uint8List actualBytes = base64Decode(
        'b3BlbnNlYS5pbyB3YW50cyB5b3UgdG8gc2lnbiBpbiB3aXRoIHlvdXIgYWNjb3VudDoKNlZXVXRRaUViU1h5NnZpWGt4czd4eXdldlFKWHJ1VkQxTm1oWDRha2RDMVoKCkNsaWNrIHRvIHNpZ24gaW4gYW5kIGFjY2VwdCB0aGUgT3BlblNlYSBUZXJtcyBvZiBTZXJ2aWNlIChodHRwczovL29wZW5zZWEuaW8vdG9zKSBhbmQgUHJpdmFjeSBQb2xpY3kgKGh0dHBzOi8vb3BlbnNlYS5pby9wcml2YWN5KS4KClVSSTogaHR0cHM6Ly9vcGVuc2VhLmlvLwpWZXJzaW9uOiAxCkNoYWluIElEOiAxCk5vbmNlOiBncThjcDI4aW5uODlyZ3ZhaG91c2QycXMzMwpJc3N1ZWQgQXQ6IDIwMjUtMDgtMjVUMTY6MjU6MzkuMzI5Wg==',
      );
      SolanaRawMessage actualSolanaRawMessage = SolanaRawMessage.fromSerializedData(actualBytes);

      // Act
      Uint8List actualSerializedData = actualSolanaRawMessage.serialize();

      // Assert
      Uint8List expectedSerializedData = base64Decode(
        'b3BlbnNlYS5pbyB3YW50cyB5b3UgdG8gc2lnbiBpbiB3aXRoIHlvdXIgYWNjb3VudDoKNlZXVXRRaUViU1h5NnZpWGt4czd4eXdldlFKWHJ1VkQxTm1oWDRha2RDMVoKCkNsaWNrIHRvIHNpZ24gaW4gYW5kIGFjY2VwdCB0aGUgT3BlblNlYSBUZXJtcyBvZiBTZXJ2aWNlIChodHRwczovL29wZW5zZWEuaW8vdG9zKSBhbmQgUHJpdmFjeSBQb2xpY3kgKGh0dHBzOi8vb3BlbnNlYS5pby9wcml2YWN5KS4KClVSSTogaHR0cHM6Ly9vcGVuc2VhLmlvLwpWZXJzaW9uOiAxCkNoYWluIElEOiAxCk5vbmNlOiBncThjcDI4aW5uODlyZ3ZhaG91c2QycXMzMwpJc3N1ZWQgQXQ6IDIwMjUtMDgtMjVUMTY6MjU6MzkuMzI5Wg==',
      );

      expect(actualSerializedData, expectedSerializedData);
    });
  });

  group('Tests of SolanaRawMessage.message getter', () {
    test('Should [return message] decoded from ASCII bytes', () {
      // Arrange
      Uint8List actualBytes = base64Decode(
        'b3BlbnNlYS5pbyB3YW50cyB5b3UgdG8gc2lnbiBpbiB3aXRoIHlvdXIgYWNjb3VudDoKNlZXVXRRaUViU1h5NnZpWGt4czd4eXdldlFKWHJ1VkQxTm1oWDRha2RDMVoKCkNsaWNrIHRvIHNpZ24gaW4gYW5kIGFjY2VwdCB0aGUgT3BlblNlYSBUZXJtcyBvZiBTZXJ2aWNlIChodHRwczovL29wZW5zZWEuaW8vdG9zKSBhbmQgUHJpdmFjeSBQb2xpY3kgKGh0dHBzOi8vb3BlbnNlYS5pby9wcml2YWN5KS4KClVSSTogaHR0cHM6Ly9vcGVuc2VhLmlvLwpWZXJzaW9uOiAxCkNoYWluIElEOiAxCk5vbmNlOiBncThjcDI4aW5uODlyZ3ZhaG91c2QycXMzMwpJc3N1ZWQgQXQ6IDIwMjUtMDgtMjVUMTY6MjU6MzkuMzI5Wg==',
      );
      SolanaRawMessage actualSolanaRawMessage = SolanaRawMessage.fromSerializedData(actualBytes);

      // Act
      String actualMessage = actualSolanaRawMessage.message;

      // Assert
      String expectedMessage = 'opensea.io wants you to sign in with your account:\n'
          '6VWUtQiEbSXy6viXkxs7xywevQJXruVD1NmhX4akdC1Z\n'
          '\n'
          'Click to sign in and accept the OpenSea Terms of Service (https://opensea.io/tos) and Privacy Policy (https://opensea.io/privacy).\n'
          '\n'
          'URI: https://opensea.io/\n'
          'Version: 1\n'
          'Chain ID: 1\n'
          'Nonce: gq8cp28inn89rgvahousd2qs33\n'
          'Issued At: 2025-08-25T16:25:39.329Z';

      expect(actualMessage, expectedMessage);
    });
  });
}
