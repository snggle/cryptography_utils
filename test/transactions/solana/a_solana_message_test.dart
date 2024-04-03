import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of ASolanaMessage.fromSerializedData()', () {
    test('Should [return SolanaLegacyMessage] when given legacy message', () {
      // Arrange
      Uint8List actualLegacyTransactionData = base64Decode(
          'AQACBB0D1AEIXs5Rz43yeayo7W0tSpSEF7kNTRVAVF4UGFj0UZgIBV3jdeGVGJKrsLg0H3NjL/I/lmh3OjD0yjTNe1wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMGRm/lIRcy/+ytunLDm+e8jOW7xfcSayxDmzpAAAAAvsFnx3LCWACVgkEemZnhkUpLl9hJ7zvQyrFIrH+YayoDAwAJAwAtMQEAAAAAAwAFAu8BAAACAgABDAIAAAAAypo7AAAAAA==');

      // Act
      ASolanaMessage actualSolanaMessage = ASolanaMessage.fromSerializedData(Uint8List.fromList(actualLegacyTransactionData));

      // Assert
      expect(actualSolanaMessage, isA<SolanaLegacyMessage>());
    });

    test('Should [return SolanaV0Message] when given version 0 data', () {
      // Arrange
      Uint8List actualV0TransactionData = base64Decode(
          'gAEACRCsVML2Bg3dHy0Va9dcV1Z/NhGHyVYhJ0jE+0MRGFemVlZ3NFh19IgWu+pj5UeQzMrHbNYffxTTr/qv3cxI4kqkZn/LU4VSNrEZJg9hJjEvfwMjmNLCvJDpEyG0zH7Y16FK5Sos5hWQvX6J14rpNOJgSgvSWHb2s1x9clh+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAAEedVb8jHAbu50xW7OaBUH/bGy3qP0jlECsc2iVrwTjwbd9uHXZaGT2cvhRs7reawctIXtX1s3kTqM9YV+/wCpUmHRSqzFvA7sY12ocFofcKOe41qazwv48izGzkkBnXqMlyWPTiSJ8bs9ECkUjg2DC1oTmdr/EIQEjnvY2+n4WZqAC/9MhzaIlsIPwUBz6/HLWqN1/oH+Tb3IK6Tft154tD/6J/XX9kp0wJsfKVh53ksJqzbfyd1RSzIap7OM5ejnStls42Wf0xNRAChL93gEW4UQqPNOSYySLu5vwwX4aYsnkR0YRptLIlfQajrMt0F6AtCnIcxppx3jdg3dGvKxBwgABQLGggMACAAJA1IqNQAAAAAMBgAEABcHCgEBBwIABAwCAAAAzye0CAAAAAAKAQQBEQknCg0ABAMCBRcaBgkOCRkSDwsQEQMBExMYDQoZFQ8LFhQCARMTEw0KKsEgmzNB1pyBAgIAAAA6AWQAAToAZAECzye0CAAAAAAIqYoBAAAAADIAUAoDBAAAAQkCwVdRxcH4wwx5hrqgGgkua/Gonv4pzAZz/LU35B3ySlkEd3Z4eQQGenVTFvHsWcITjSSy666/XikzqLiO11a0SwY8rT5d3C+q84sDvr+7AA==');

      // Act
      ASolanaMessage actualSolanaMessage = ASolanaMessage.fromSerializedData(Uint8List.fromList(actualV0TransactionData));

      // Assert
      expect(actualSolanaMessage, isA<SolanaV0Message>());
    });

    test('Should [throw UnimplementedError] when given version 1 data', () {
      // Arrange
      Uint8List actualV1TransactionData = base64Decode(
          'gQEACRCsVML2Bg3dHy0Va9dcV1Z/NhGHyVYhJ0jE+0MRGFemVlZ3NFh19IgWu+pj5UeQzMrHbNYffxTTr/qv3cxI4kqkZn/LU4VSNrEZJg9hJjEvfwMjmNLCvJDpEyG0zH7Y16FK5Sos5hWQvX6J14rpNOJgSgvSWHb2s1x9clh+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwZGb+UhFzL/7K26csOb57yM5bvF9xJrLEObOkAAAAAEedVb8jHAbu50xW7OaBUH/bGy3qP0jlECsc2iVrwTjwbd9uHXZaGT2cvhRs7reawctIXtX1s3kTqM9YV+/wCpUmHRSqzFvA7sY12ocFofcKOe41qazwv48izGzkkBnXqMlyWPTiSJ8bs9ECkUjg2DC1oTmdr/EIQEjnvY2+n4WZqAC/9MhzaIlsIPwUBz6/HLWqN1/oH+Tb3IK6Tft154tD/6J/XX9kp0wJsfKVh53ksJqzbfyd1RSzIap7OM5ejnStls42Wf0xNRAChL93gEW4UQqPNOSYySLu5vwwX4aYsnkR0YRptLIlfQajrMt0F6AtCnIcxppx3jdg3dGvKxBwgABQLGggMACAAJA1IqNQAAAAAMBgAEABcHCgEBBwIABAwCAAAAzye0CAAAAAAKAQQBEQknCg0ABAMCBRcaBgkOCRkSDwsQEQMBExMYDQoZFQ8LFhQCARMTEw0KKsEgmzNB1pyBAgIAAAA6AWQAAToAZAECzye0CAAAAAAIqYoBAAAAADIAUAoDBAAAAQkCwVdRxcH4wwx5hrqgGgkua/Gonv4pzAZz/LU35B3ySlkEd3Z4eQQGenVTFvHsWcITjSSy666/XikzqLiO11a0SwY8rT5d3C+q84sDvr+7AA==');

      // Assert
      expect(
        () => ASolanaMessage.fromSerializedData(Uint8List.fromList(actualV1TransactionData)),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });
}
