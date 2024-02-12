import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of Strobe process', () {
    Strobe actualStrobe = Strobe.initStrobe('Merlin v1.0', StrobeSecurityLevel.sec128);

    test('Should [return Strobe] with initialized values', () {
      // Assert
      Strobe expectedStrobe = Strobe(
        duplexRate: 168,
        strobeRate: 166,
        storage: base64Decode(
            'ABJNZXJsaW4gdjEuMDEuMC4yAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        tempStateBuffer: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        role: StrobeRole.iNone,
        actualState: <BigInt>[
          BigInt.parse('15732760117283024284'),
          BigInt.parse('7148731399858333482'),
          BigInt.parse('17736887638809840860'),
          BigInt.parse('8986208414416386931'),
          BigInt.parse('1362636194284314579'),
          BigInt.parse('10670133630811458178'),
          BigInt.parse('1311442180434980642'),
          BigInt.parse('17774622128609610899'),
          BigInt.parse('18139130285017577185'),
          BigInt.parse('9078858180030973384'),
          BigInt.parse('10977805366776267900'),
          BigInt.parse('8318718520013631177'),
          BigInt.parse('5981632673086097697'),
          BigInt.parse('410029404249115721'),
          BigInt.parse('9835506231314780030'),
          BigInt.parse('3799917332135636837'),
          BigInt.parse('5771320564411973322'),
          BigInt.parse('5571065684143630528'),
          BigInt.parse('7316341022443258643'),
          BigInt.parse('15357446029961394605'),
          BigInt.parse('11076206493035689204'),
          BigInt.parse('15022785832750611421'),
          BigInt.parse('16831740331416418459'),
          BigInt.parse('7948496436356706375'),
          BigInt.parse('17797057768635628286'),
        ],
        initializedBool: true,
        positionBegin: 1,
        currentFlags: 18,
        buffer: base64Decode('ABJNZXJsaW4gdjEuMA=='),
      );

      expect(actualStrobe, expectedStrobe);
    });

    // **************************************************************************************************

    test('Should [return Strobe] with additional data authenticated (append "dom-sep" message - 1st step)', () {
      // Act
      actualStrobe.authenticateAdditionalData(base64Decode('ZG9tLXNlcA4AAAA='), metaBool: true);

      // Assert
      Strobe expectedStrobe = Strobe(
        duplexRate: 168,
        strobeRate: 166,
        storage: base64Decode(
            'ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        tempStateBuffer: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        role: StrobeRole.iNone,
        actualState: <BigInt>[
          BigInt.parse('15732760117283024284'),
          BigInt.parse('7148731399858333482'),
          BigInt.parse('17736887638809840860'),
          BigInt.parse('8986208414416386931'),
          BigInt.parse('1362636194284314579'),
          BigInt.parse('10670133630811458178'),
          BigInt.parse('1311442180434980642'),
          BigInt.parse('17774622128609610899'),
          BigInt.parse('18139130285017577185'),
          BigInt.parse('9078858180030973384'),
          BigInt.parse('10977805366776267900'),
          BigInt.parse('8318718520013631177'),
          BigInt.parse('5981632673086097697'),
          BigInt.parse('410029404249115721'),
          BigInt.parse('9835506231314780030'),
          BigInt.parse('3799917332135636837'),
          BigInt.parse('5771320564411973322'),
          BigInt.parse('5571065684143630528'),
          BigInt.parse('7316341022443258643'),
          BigInt.parse('15357446029961394605'),
          BigInt.parse('11076206493035689204'),
          BigInt.parse('15022785832750611421'),
          BigInt.parse('16831740331416418459'),
          BigInt.parse('7948496436356706375'),
          BigInt.parse('17797057768635628286'),
        ],
        initializedBool: true,
        positionBegin: 14,
        currentFlags: 18,
        buffer: base64Decode('ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAA='),
      );

      expect(actualStrobe, expectedStrobe);
    });

    test('Should [return Strobe] with additional data authenticated (append "dom-sep" message - 2nd step)', () {
      // Act
      actualStrobe.authenticateAdditionalData(base64Decode('U2lnbmluZ0NvbnRleHQ='), metaBool: false);

      // Assert
      Strobe expectedStrobe = Strobe(
        duplexRate: 168,
        strobeRate: 166,
        storage: base64Decode(
            'ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAAOAlNpZ25pbmdDb250ZXh0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        tempStateBuffer: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        role: StrobeRole.iNone,
        actualState: <BigInt>[
          BigInt.parse('15732760117283024284'),
          BigInt.parse('7148731399858333482'),
          BigInt.parse('17736887638809840860'),
          BigInt.parse('8986208414416386931'),
          BigInt.parse('1362636194284314579'),
          BigInt.parse('10670133630811458178'),
          BigInt.parse('1311442180434980642'),
          BigInt.parse('17774622128609610899'),
          BigInt.parse('18139130285017577185'),
          BigInt.parse('9078858180030973384'),
          BigInt.parse('10977805366776267900'),
          BigInt.parse('8318718520013631177'),
          BigInt.parse('5981632673086097697'),
          BigInt.parse('410029404249115721'),
          BigInt.parse('9835506231314780030'),
          BigInt.parse('3799917332135636837'),
          BigInt.parse('5771320564411973322'),
          BigInt.parse('5571065684143630528'),
          BigInt.parse('7316341022443258643'),
          BigInt.parse('15357446029961394605'),
          BigInt.parse('11076206493035689204'),
          BigInt.parse('15022785832750611421'),
          BigInt.parse('16831740331416418459'),
          BigInt.parse('7948496436356706375'),
          BigInt.parse('17797057768635628286'),
        ],
        initializedBool: true,
        positionBegin: 27,
        currentFlags: 2,
        buffer: base64Decode('ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAAOAlNpZ25pbmdDb250ZXh0'),
      );

      expect(actualStrobe, expectedStrobe);
    });

    // **************************************************************************************************

    test('Should [return Strobe] with additional data authenticated (append "substrate" message - 1st step)', () {
      // Act
      actualStrobe.authenticateAdditionalData(base64Decode('CQAAAA=='), metaBool: true);

      // Assert
      Strobe expectedStrobe = Strobe(
        duplexRate: 168,
        strobeRate: 166,
        storage: base64Decode(
            'ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAAOAlNpZ25pbmdDb250ZXh0GxIJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        tempStateBuffer: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        role: StrobeRole.iNone,
        actualState: <BigInt>[
          BigInt.parse('15732760117283024284'),
          BigInt.parse('7148731399858333482'),
          BigInt.parse('17736887638809840860'),
          BigInt.parse('8986208414416386931'),
          BigInt.parse('1362636194284314579'),
          BigInt.parse('10670133630811458178'),
          BigInt.parse('1311442180434980642'),
          BigInt.parse('17774622128609610899'),
          BigInt.parse('18139130285017577185'),
          BigInt.parse('9078858180030973384'),
          BigInt.parse('10977805366776267900'),
          BigInt.parse('8318718520013631177'),
          BigInt.parse('5981632673086097697'),
          BigInt.parse('410029404249115721'),
          BigInt.parse('9835506231314780030'),
          BigInt.parse('3799917332135636837'),
          BigInt.parse('5771320564411973322'),
          BigInt.parse('5571065684143630528'),
          BigInt.parse('7316341022443258643'),
          BigInt.parse('15357446029961394605'),
          BigInt.parse('11076206493035689204'),
          BigInt.parse('15022785832750611421'),
          BigInt.parse('16831740331416418459'),
          BigInt.parse('7948496436356706375'),
          BigInt.parse('17797057768635628286'),
        ],
        initializedBool: true,
        positionBegin: 43,
        currentFlags: 18,
        buffer: base64Decode('ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAAOAlNpZ25pbmdDb250ZXh0GxIJAAAA'),
      );

      expect(actualStrobe, expectedStrobe);
    });

    test('Should [return Strobe] with additional data authenticated (append "substrate" message - 2nd step)', () {
      // Act
      actualStrobe.authenticateAdditionalData(base64Decode('c3Vic3RyYXRl'), metaBool: false);

      // Assert
      Strobe expectedStrobe = Strobe(
        duplexRate: 168,
        strobeRate: 166,
        storage: base64Decode(
            'ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAAOAlNpZ25pbmdDb250ZXh0GxIJAAAAKwJzdWJzdHJhdGUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        tempStateBuffer: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        role: StrobeRole.iNone,
        actualState: <BigInt>[
          BigInt.parse('15732760117283024284'),
          BigInt.parse('7148731399858333482'),
          BigInt.parse('17736887638809840860'),
          BigInt.parse('8986208414416386931'),
          BigInt.parse('1362636194284314579'),
          BigInt.parse('10670133630811458178'),
          BigInt.parse('1311442180434980642'),
          BigInt.parse('17774622128609610899'),
          BigInt.parse('18139130285017577185'),
          BigInt.parse('9078858180030973384'),
          BigInt.parse('10977805366776267900'),
          BigInt.parse('8318718520013631177'),
          BigInt.parse('5981632673086097697'),
          BigInt.parse('410029404249115721'),
          BigInt.parse('9835506231314780030'),
          BigInt.parse('3799917332135636837'),
          BigInt.parse('5771320564411973322'),
          BigInt.parse('5571065684143630528'),
          BigInt.parse('7316341022443258643'),
          BigInt.parse('15357446029961394605'),
          BigInt.parse('11076206493035689204'),
          BigInt.parse('15022785832750611421'),
          BigInt.parse('16831740331416418459'),
          BigInt.parse('7948496436356706375'),
          BigInt.parse('17797057768635628286'),
        ],
        initializedBool: true,
        positionBegin: 49,
        currentFlags: 2,
        buffer: base64Decode('ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAAOAlNpZ25pbmdDb250ZXh0GxIJAAAAKwJzdWJzdHJhdGU='),
      );

      expect(actualStrobe, expectedStrobe);
    });

    // **************************************************************************************************

    test('Should [return Strobe] with additional data authenticated (append "sign-bytes" message - 1st step)', () {
      // Act
      actualStrobe.authenticateAdditionalData(base64Decode('c2lnbi1ieXRlcyAAAAA='), metaBool: true);

      // Assert
      Strobe expectedStrobe = Strobe(
        duplexRate: 168,
        strobeRate: 166,
        storage: base64Decode(
            'ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAAOAlNpZ25pbmdDb250ZXh0GxIJAAAAKwJzdWJzdHJhdGUxEnNpZ24tYnl0ZXMgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        tempStateBuffer: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        role: StrobeRole.iNone,
        actualState: <BigInt>[
          BigInt.parse('15732760117283024284'),
          BigInt.parse('7148731399858333482'),
          BigInt.parse('17736887638809840860'),
          BigInt.parse('8986208414416386931'),
          BigInt.parse('1362636194284314579'),
          BigInt.parse('10670133630811458178'),
          BigInt.parse('1311442180434980642'),
          BigInt.parse('17774622128609610899'),
          BigInt.parse('18139130285017577185'),
          BigInt.parse('9078858180030973384'),
          BigInt.parse('10977805366776267900'),
          BigInt.parse('8318718520013631177'),
          BigInt.parse('5981632673086097697'),
          BigInt.parse('410029404249115721'),
          BigInt.parse('9835506231314780030'),
          BigInt.parse('3799917332135636837'),
          BigInt.parse('5771320564411973322'),
          BigInt.parse('5571065684143630528'),
          BigInt.parse('7316341022443258643'),
          BigInt.parse('15357446029961394605'),
          BigInt.parse('11076206493035689204'),
          BigInt.parse('15022785832750611421'),
          BigInt.parse('16831740331416418459'),
          BigInt.parse('7948496436356706375'),
          BigInt.parse('17797057768635628286'),
        ],
        initializedBool: true,
        positionBegin: 60,
        currentFlags: 18,
        buffer: base64Decode('ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAAOAlNpZ25pbmdDb250ZXh0GxIJAAAAKwJzdWJzdHJhdGUxEnNpZ24tYnl0ZXMgAAAA'),
      );

      expect(actualStrobe, expectedStrobe);
    });

    test('Should [return Strobe] with additional data authenticated (append "sign-bytes" message - 2nd step)', () {
      // Act
      actualStrobe.authenticateAdditionalData(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='), metaBool: false);

      // Assert
      Strobe expectedStrobe = Strobe(
        duplexRate: 168,
        strobeRate: 166,
        storage: base64Decode(
            'ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAAOAlNpZ25pbmdDb250ZXh0GxIJAAAAKwJzdWJzdHJhdGUxEnNpZ24tYnl0ZXMgAAAAPAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        tempStateBuffer: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        role: StrobeRole.iNone,
        actualState: <BigInt>[
          BigInt.parse('15732760117283024284'),
          BigInt.parse('7148731399858333482'),
          BigInt.parse('17736887638809840860'),
          BigInt.parse('8986208414416386931'),
          BigInt.parse('1362636194284314579'),
          BigInt.parse('10670133630811458178'),
          BigInt.parse('1311442180434980642'),
          BigInt.parse('17774622128609610899'),
          BigInt.parse('18139130285017577185'),
          BigInt.parse('9078858180030973384'),
          BigInt.parse('10977805366776267900'),
          BigInt.parse('8318718520013631177'),
          BigInt.parse('5981632673086097697'),
          BigInt.parse('410029404249115721'),
          BigInt.parse('9835506231314780030'),
          BigInt.parse('3799917332135636837'),
          BigInt.parse('5771320564411973322'),
          BigInt.parse('5571065684143630528'),
          BigInt.parse('7316341022443258643'),
          BigInt.parse('15357446029961394605'),
          BigInt.parse('11076206493035689204'),
          BigInt.parse('15022785832750611421'),
          BigInt.parse('16831740331416418459'),
          BigInt.parse('7948496436356706375'),
          BigInt.parse('17797057768635628286'),
        ],
        initializedBool: true,
        positionBegin: 76,
        currentFlags: 2,
        buffer: base64Decode(
            'ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAAOAlNpZ25pbmdDb250ZXh0GxIJAAAAKwJzdWJzdHJhdGUxEnNpZ24tYnl0ZXMgAAAAPAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=='),
      );

      expect(actualStrobe, expectedStrobe);
    });

    // **************************************************************************************************

    test('Should [return Strobe] with additional data authenticated (append "proto-name" message - 1st step)', () {
      // Act
      actualStrobe.authenticateAdditionalData(base64Decode('cHJvdG8tbmFtZQsAAAA='), metaBool: true);

      // Assert
      Strobe expectedStrobe = Strobe(
        duplexRate: 168,
        strobeRate: 166,
        storage: base64Decode(
            'ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAAOAlNpZ25pbmdDb250ZXh0GxIJAAAAKwJzdWJzdHJhdGUxEnNpZ24tYnl0ZXMgAAAAPAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEwScHJvdG8tbmFtZQsAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        tempStateBuffer: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        role: StrobeRole.iNone,
        actualState: <BigInt>[
          BigInt.parse('15732760117283024284'),
          BigInt.parse('7148731399858333482'),
          BigInt.parse('17736887638809840860'),
          BigInt.parse('8986208414416386931'),
          BigInt.parse('1362636194284314579'),
          BigInt.parse('10670133630811458178'),
          BigInt.parse('1311442180434980642'),
          BigInt.parse('17774622128609610899'),
          BigInt.parse('18139130285017577185'),
          BigInt.parse('9078858180030973384'),
          BigInt.parse('10977805366776267900'),
          BigInt.parse('8318718520013631177'),
          BigInt.parse('5981632673086097697'),
          BigInt.parse('410029404249115721'),
          BigInt.parse('9835506231314780030'),
          BigInt.parse('3799917332135636837'),
          BigInt.parse('5771320564411973322'),
          BigInt.parse('5571065684143630528'),
          BigInt.parse('7316341022443258643'),
          BigInt.parse('15357446029961394605'),
          BigInt.parse('11076206493035689204'),
          BigInt.parse('15022785832750611421'),
          BigInt.parse('16831740331416418459'),
          BigInt.parse('7948496436356706375'),
          BigInt.parse('17797057768635628286'),
        ],
        initializedBool: true,
        positionBegin: 110,
        currentFlags: 18,
        buffer: base64Decode(
            'ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAAOAlNpZ25pbmdDb250ZXh0GxIJAAAAKwJzdWJzdHJhdGUxEnNpZ24tYnl0ZXMgAAAAPAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEwScHJvdG8tbmFtZQsAAAA='),
      );

      expect(actualStrobe, expectedStrobe);
    });

    test('Should [return Strobe] with additional data authenticated (append "proto-name" message - 2nd step)', () {
      // Act
      actualStrobe.authenticateAdditionalData(base64Decode('U2Nobm9yci1zaWc='), metaBool: false);

      // Assert
      Strobe expectedStrobe = Strobe(
        duplexRate: 168,
        strobeRate: 166,
        storage: base64Decode(
            'ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAAOAlNpZ25pbmdDb250ZXh0GxIJAAAAKwJzdWJzdHJhdGUxEnNpZ24tYnl0ZXMgAAAAPAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEwScHJvdG8tbmFtZQsAAABuAlNjaG5vcnItc2lnAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        tempStateBuffer: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        role: StrobeRole.iNone,
        actualState: <BigInt>[
          BigInt.parse('15732760117283024284'),
          BigInt.parse('7148731399858333482'),
          BigInt.parse('17736887638809840860'),
          BigInt.parse('8986208414416386931'),
          BigInt.parse('1362636194284314579'),
          BigInt.parse('10670133630811458178'),
          BigInt.parse('1311442180434980642'),
          BigInt.parse('17774622128609610899'),
          BigInt.parse('18139130285017577185'),
          BigInt.parse('9078858180030973384'),
          BigInt.parse('10977805366776267900'),
          BigInt.parse('8318718520013631177'),
          BigInt.parse('5981632673086097697'),
          BigInt.parse('410029404249115721'),
          BigInt.parse('9835506231314780030'),
          BigInt.parse('3799917332135636837'),
          BigInt.parse('5771320564411973322'),
          BigInt.parse('5571065684143630528'),
          BigInt.parse('7316341022443258643'),
          BigInt.parse('15357446029961394605'),
          BigInt.parse('11076206493035689204'),
          BigInt.parse('15022785832750611421'),
          BigInt.parse('16831740331416418459'),
          BigInt.parse('7948496436356706375'),
          BigInt.parse('17797057768635628286'),
        ],
        initializedBool: true,
        positionBegin: 126,
        currentFlags: 2,
        buffer: base64Decode(
            'ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAAOAlNpZ25pbmdDb250ZXh0GxIJAAAAKwJzdWJzdHJhdGUxEnNpZ24tYnl0ZXMgAAAAPAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEwScHJvdG8tbmFtZQsAAABuAlNjaG5vcnItc2ln'),
      );

      expect(actualStrobe, expectedStrobe);
    });

    // **************************************************************************************************

    test('Should [return Strobe] with additional data authenticated (append "sign:pk" message - 1st step)', () {
      // Act
      actualStrobe.authenticateAdditionalData(base64Decode('c2lnbjpwayAAAAA='), metaBool: true);

      // Assert
      Strobe expectedStrobe = Strobe(
        duplexRate: 168,
        strobeRate: 166,
        storage: base64Decode(
            'ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAAOAlNpZ25pbmdDb250ZXh0GxIJAAAAKwJzdWJzdHJhdGUxEnNpZ24tYnl0ZXMgAAAAPAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEwScHJvdG8tbmFtZQsAAABuAlNjaG5vcnItc2lnfhJzaWduOnBrIAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        tempStateBuffer: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        role: StrobeRole.iNone,
        actualState: <BigInt>[
          BigInt.parse('15732760117283024284'),
          BigInt.parse('7148731399858333482'),
          BigInt.parse('17736887638809840860'),
          BigInt.parse('8986208414416386931'),
          BigInt.parse('1362636194284314579'),
          BigInt.parse('10670133630811458178'),
          BigInt.parse('1311442180434980642'),
          BigInt.parse('17774622128609610899'),
          BigInt.parse('18139130285017577185'),
          BigInt.parse('9078858180030973384'),
          BigInt.parse('10977805366776267900'),
          BigInt.parse('8318718520013631177'),
          BigInt.parse('5981632673086097697'),
          BigInt.parse('410029404249115721'),
          BigInt.parse('9835506231314780030'),
          BigInt.parse('3799917332135636837'),
          BigInt.parse('5771320564411973322'),
          BigInt.parse('5571065684143630528'),
          BigInt.parse('7316341022443258643'),
          BigInt.parse('15357446029961394605'),
          BigInt.parse('11076206493035689204'),
          BigInt.parse('15022785832750611421'),
          BigInt.parse('16831740331416418459'),
          BigInt.parse('7948496436356706375'),
          BigInt.parse('17797057768635628286'),
        ],
        initializedBool: true,
        positionBegin: 139,
        currentFlags: 18,
        buffer: base64Decode(
            'ABJNZXJsaW4gdjEuMAESZG9tLXNlcA4AAAAOAlNpZ25pbmdDb250ZXh0GxIJAAAAKwJzdWJzdHJhdGUxEnNpZ24tYnl0ZXMgAAAAPAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEwScHJvdG8tbmFtZQsAAABuAlNjaG5vcnItc2lnfhJzaWduOnBrIAAAAA=='),
      );

      expect(actualStrobe, expectedStrobe);
    });

    test('Should [return Strobe] with additional data authenticated (append "sign:pk" message - 2nd step)', () {
      // Act
      actualStrobe.authenticateAdditionalData(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='), metaBool: false);

      // Assert
      Strobe expectedStrobe = Strobe(
        duplexRate: 168,
        strobeRate: 166,
        storage: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAHNlcA4AAAAOAlNpZ25pbmdDb250ZXh0GxIJAAAAKwJzdWJzdHJhdGUxEnNpZ24tYnl0ZXMgAAAAPAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEwScHJvdG8tbmFtZQsAAABuAlNjaG5vcnItc2lnfhJzaWduOnBrIAAAAIsCAAAAAAAAAAAAAAAAAJiE'),
        tempStateBuffer: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        role: StrobeRole.iNone,
        actualState: <BigInt>[
          BigInt.parse('16036871047007580093'),
          BigInt.parse('7844709910489428917'),
          BigInt.parse('1515913644917642392'),
          BigInt.parse('17912127166860149410'),
          BigInt.parse('14914718275398166812'),
          BigInt.parse('3604792245582359807'),
          BigInt.parse('10847839558022002561'),
          BigInt.parse('14746144051932880010'),
          BigInt.parse('4746739973748309867'),
          BigInt.parse('990189750348740076'),
          BigInt.parse('10136391732916542928'),
          BigInt.parse('6922727385345399016'),
          BigInt.parse('3061009579429652767'),
          BigInt.parse('12196228396935957030'),
          BigInt.parse('3695450093331578217'),
          BigInt.parse('787171926244369017'),
          BigInt.parse('4480784229604710396'),
          BigInt.parse('15852282994502245028'),
          BigInt.parse('9901056529697793439'),
          BigInt.parse('1871234457338695288'),
          BigInt.parse('11888590533027668720'),
          BigInt.parse('8707130011255490016'),
          BigInt.parse('16937648610715585450'),
          BigInt.parse('6591312797976026969'),
          BigInt.parse('16401675315775941034'),
        ],
        initializedBool: true,
        positionBegin: 0,
        currentFlags: 2,
        buffer: base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAA=='),
      );

      expect(actualStrobe, expectedStrobe);
    });

    // **************************************************************************************************

    test('Should [return Strobe] with additional data authenticated (append "sign:R" message - 1st step)', () {
      // Act
      actualStrobe.authenticateAdditionalData(base64Decode('c2lnbjpSIAAAAA=='), metaBool: true);

      // Assert
      Strobe expectedStrobe = Strobe(
        duplexRate: 168,
        strobeRate: 166,
        storage: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAAASc2lnbjpSIAAAAG5pbmdDb250ZXh0GxIJAAAAKwJzdWJzdHJhdGUxEnNpZ24tYnl0ZXMgAAAAPAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEwScHJvdG8tbmFtZQsAAABuAlNjaG5vcnItc2lnfhJzaWduOnBrIAAAAIsCAAAAAAAAAAAAAAAAAJiE'),
        tempStateBuffer: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        role: StrobeRole.iNone,
        actualState: <BigInt>[
          BigInt.parse('16036871047007580093'),
          BigInt.parse('7844709910489428917'),
          BigInt.parse('1515913644917642392'),
          BigInt.parse('17912127166860149410'),
          BigInt.parse('14914718275398166812'),
          BigInt.parse('3604792245582359807'),
          BigInt.parse('10847839558022002561'),
          BigInt.parse('14746144051932880010'),
          BigInt.parse('4746739973748309867'),
          BigInt.parse('990189750348740076'),
          BigInt.parse('10136391732916542928'),
          BigInt.parse('6922727385345399016'),
          BigInt.parse('3061009579429652767'),
          BigInt.parse('12196228396935957030'),
          BigInt.parse('3695450093331578217'),
          BigInt.parse('787171926244369017'),
          BigInt.parse('4480784229604710396'),
          BigInt.parse('15852282994502245028'),
          BigInt.parse('9901056529697793439'),
          BigInt.parse('1871234457338695288'),
          BigInt.parse('11888590533027668720'),
          BigInt.parse('8707130011255490016'),
          BigInt.parse('16937648610715585450'),
          BigInt.parse('6591312797976026969'),
          BigInt.parse('16401675315775941034'),
        ],
        initializedBool: true,
        positionBegin: 20,
        currentFlags: 18,
        buffer: base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAASc2lnbjpSIAAAAA=='),
      );

      expect(actualStrobe, expectedStrobe);
    });

    test('Should [return Strobe] with additional data authenticated (append "sign:R" message - 2nd step)', () {
      // Act
      actualStrobe.authenticateAdditionalData(base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='), metaBool: false);

      // Assert
      Strobe expectedStrobe = Strobe(
        duplexRate: 168,
        strobeRate: 166,
        storage: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAAASc2lnbjpSIAAAABQCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAtYnl0ZXMgAAAAPAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEwScHJvdG8tbmFtZQsAAABuAlNjaG5vcnItc2lnfhJzaWduOnBrIAAAAIsCAAAAAAAAAAAAAAAAAJiE'),
        tempStateBuffer: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        role: StrobeRole.iNone,
        actualState: <BigInt>[
          BigInt.parse('16036871047007580093'),
          BigInt.parse('7844709910489428917'),
          BigInt.parse('1515913644917642392'),
          BigInt.parse('17912127166860149410'),
          BigInt.parse('14914718275398166812'),
          BigInt.parse('3604792245582359807'),
          BigInt.parse('10847839558022002561'),
          BigInt.parse('14746144051932880010'),
          BigInt.parse('4746739973748309867'),
          BigInt.parse('990189750348740076'),
          BigInt.parse('10136391732916542928'),
          BigInt.parse('6922727385345399016'),
          BigInt.parse('3061009579429652767'),
          BigInt.parse('12196228396935957030'),
          BigInt.parse('3695450093331578217'),
          BigInt.parse('787171926244369017'),
          BigInt.parse('4480784229604710396'),
          BigInt.parse('15852282994502245028'),
          BigInt.parse('9901056529697793439'),
          BigInt.parse('1871234457338695288'),
          BigInt.parse('11888590533027668720'),
          BigInt.parse('8707130011255490016'),
          BigInt.parse('16937648610715585450'),
          BigInt.parse('6591312797976026969'),
          BigInt.parse('16401675315775941034'),
        ],
        initializedBool: true,
        positionBegin: 32,
        currentFlags: 2,
        buffer: base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAASc2lnbjpSIAAAABQCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='),
      );

      expect(actualStrobe, expectedStrobe);
    });

    // **************************************************************************************************

    test('Should [return Strobe] with additional data authenticated (append "sign:c" message)', () {
      // Act
      actualStrobe.authenticateAdditionalData(base64Decode('c2lnbjpjQAAAAA=='), metaBool: true);

      // Assert
      Strobe expectedStrobe = Strobe(
        duplexRate: 168,
        strobeRate: 166,
        storage: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAAASc2lnbjpSIAAAABQCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgEnNpZ246Y0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEwScHJvdG8tbmFtZQsAAABuAlNjaG5vcnItc2lnfhJzaWduOnBrIAAAAIsCAAAAAAAAAAAAAAAAAJiE'),
        tempStateBuffer: base64Decode(
            'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
        role: StrobeRole.iNone,
        actualState: <BigInt>[
          BigInt.parse('16036871047007580093'),
          BigInt.parse('7844709910489428917'),
          BigInt.parse('1515913644917642392'),
          BigInt.parse('17912127166860149410'),
          BigInt.parse('14914718275398166812'),
          BigInt.parse('3604792245582359807'),
          BigInt.parse('10847839558022002561'),
          BigInt.parse('14746144051932880010'),
          BigInt.parse('4746739973748309867'),
          BigInt.parse('990189750348740076'),
          BigInt.parse('10136391732916542928'),
          BigInt.parse('6922727385345399016'),
          BigInt.parse('3061009579429652767'),
          BigInt.parse('12196228396935957030'),
          BigInt.parse('3695450093331578217'),
          BigInt.parse('787171926244369017'),
          BigInt.parse('4480784229604710396'),
          BigInt.parse('15852282994502245028'),
          BigInt.parse('9901056529697793439'),
          BigInt.parse('1871234457338695288'),
          BigInt.parse('11888590533027668720'),
          BigInt.parse('8707130011255490016'),
          BigInt.parse('16937648610715585450'),
          BigInt.parse('6591312797976026969'),
          BigInt.parse('16401675315775941034'),
        ],
        initializedBool: true,
        positionBegin: 66,
        currentFlags: 18,
        buffer: base64Decode('AAAAAAAAAAAAAAAAAAAAAAAAAAASc2lnbjpSIAAAABQCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgEnNpZ246Y0AAAAA='),
      );

      expect(actualStrobe, expectedStrobe);
    });

    // **************************************************************************************************

    test('Should [return Strobe] after calling Pseudo-Random Function (PRF)', () {
      // Act
      actualStrobe.prf(64);

      // Assert
      Strobe expectedStrobe = Strobe(
        duplexRate: 168,
        strobeRate: 166,
        storage: base64Decode(
            'uWB1/w8ucVgfoxK/IjcFqwMRowq9LIAWizAGKEz2Kakl35b+oneit7sGO2KWFRkuayKVJPWnWTmALIVomyaQKAAgEnNpZ246Y0AAAABCB04EAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEwScHJvdG8tbmFtZQsAAABuAlNjaG5vcnItc2lnfhJzaWduOnBrIAAAAIsCAAAAAAAAAAAAAAAAAJgE'),
        tempStateBuffer: base64Decode(
            'uWB1/w8ucVgfoxK/IjcFqwMRowq9LIAWizAGKEz2Kakl35b+oneit7sGO2KWFRkuayKVJPWnWTmALIVomyaQKFU7MCJYtxpaYPBi6/iDVA3Z/9BIbEqzIWPbAvqLCwI9S062J6ilv7LGlHaGTDT0X/DyJY3/v/P6uHG7WcP2H4e0ZsLslCq8MN/XI3fJnWPEjzrPZFRoD+AtsvjCnd1PnRG9zR7F3VtH'),
        role: StrobeRole.iNone,
        actualState: <BigInt>[
          BigInt.parse('6372925593951232185'),
          BigInt.parse('12323316577743315743'),
          BigInt.parse('1621345056292278531'),
          BigInt.parse('12189544673404399755'),
          BigInt.parse('13232270197107646245'),
          BigInt.parse('3321709935799764667'),
          BigInt.parse('4132518804411720299'),
          BigInt.parse('2922878607078796416'),
          BigInt.parse('6492703401966582613'),
          BigInt.parse('960537725661016160'),
          BigInt.parse('2428366453021409241'),
          BigInt.parse('4396088882089876323'),
          BigInt.parse('12880195600942255691'),
          BigInt.parse('6914208831198631110'),
          BigInt.parse('18083008033128313584'),
          BigInt.parse('9736772238282813880'),
          BigInt.parse('3511728628557833908'),
          BigInt.parse('14151327942741055455'),
          BigInt.parse('16145237900824361615'),
          BigInt.parse('11335522456765510189'),
          BigInt.parse('5141947238268648721'),
          BigInt.parse('7475950799564400648'),
          BigInt.parse('5476892088710895560'),
          BigInt.parse('16951428352939238124'),
          BigInt.parse('4720972338030646388'),
        ],
        initializedBool: true,
        positionBegin: 0,
        currentFlags: 7,
        buffer: base64Decode('uWB1/w8ucVgfoxK/IjcFqwMRowq9LIAWizAGKEz2Kakl35b+oneit7sGO2KWFRkuayKVJPWnWTmALIVomyaQKA=='),
      );

      expect(actualStrobe, expectedStrobe);
    });
  });
}
