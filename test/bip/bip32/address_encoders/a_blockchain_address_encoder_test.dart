import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of ABlockchainAddressEncoder.fromSerializedType()', () {
    test('Should [return BitcoinP2PKHAddressEncoder] when type is "bitcoinP2PKH(compressed)"', () {
      // Arrange
      String actualSerializedType = 'bitcoinP2PKH(compressed)';

      // Act
      ABlockchainAddressEncoder<ABip32PublicKey> actualAddressEncoder = ABlockchainAddressEncoder.fromSerializedType(actualSerializedType);

      // Assert
      expect(actualAddressEncoder, isA<BitcoinP2PKHAddressEncoder>());
      expect((actualAddressEncoder as BitcoinP2PKHAddressEncoder).publicKeyMode, PublicKeyMode.compressed);
    });

    test('Should [return BitcoinP2PKHAddressEncoder] when type is "bitcoinP2PKH(uncompressed)"', () {
      // Arrange
      String actualSerializedType = 'bitcoinP2PKH(uncompressed)';

      // Act
      ABlockchainAddressEncoder<ABip32PublicKey> actualAddressEncoder = ABlockchainAddressEncoder.fromSerializedType(actualSerializedType);

      // Assert
      expect(actualAddressEncoder, isA<BitcoinP2PKHAddressEncoder>());
      expect((actualAddressEncoder as BitcoinP2PKHAddressEncoder).publicKeyMode, PublicKeyMode.uncompressed);
    });

    test('Should [return BitcoinP2SHAddressEncoder] when type is "bitcoinP2SH()"', () {
      // Arrange
      String actualSerializedType = 'bitcoinP2SH()';

      // Act
      ABlockchainAddressEncoder<ABip32PublicKey> actualAddressEncoder = ABlockchainAddressEncoder.fromSerializedType(actualSerializedType);

      // Assert
      expect(actualAddressEncoder, isA<BitcoinP2SHAddressEncoder>());
    });

    test('Should [return BitcoinP2WPKHAddressEncoder] when type is "bitcoinP2WPKH(bc)"', () {
      // Arrange
      String actualSerializedType = 'bitcoinP2WPKH(bc)';

      // Act
      ABlockchainAddressEncoder<ABip32PublicKey> actualAddressEncoder = ABlockchainAddressEncoder.fromSerializedType(actualSerializedType);

      // Assert
      expect(actualAddressEncoder, isA<BitcoinP2WPKHAddressEncoder>());
      expect((actualAddressEncoder as BitcoinP2WPKHAddressEncoder).hrp, 'bc');
    });

    test('Should [return CosmosAddressEncoder] when type is "cosmos(cosmos)"', () {
      // Arrange
      String actualSerializedType = 'cosmos(cosmos)';

      // Act
      ABlockchainAddressEncoder<ABip32PublicKey> actualAddressEncoder = ABlockchainAddressEncoder.fromSerializedType(actualSerializedType);

      // Assert
      expect(actualAddressEncoder, isA<CosmosAddressEncoder>());
      expect((actualAddressEncoder as CosmosAddressEncoder).hrp, 'cosmos');
    });

    test('Should [return EthereumAddressEncoder] when type is "ethereum(true)"', () {
      // Arrange
      String actualSerializedType = 'ethereum(true)';

      // Act
      ABlockchainAddressEncoder<ABip32PublicKey> actualAddressEncoder = ABlockchainAddressEncoder.fromSerializedType(actualSerializedType);

      // Assert
      expect(actualAddressEncoder, isA<EthereumAddressEncoder>());
      expect((actualAddressEncoder as EthereumAddressEncoder).skipChecksumBool, true);
    });

    test('Should [return EthereumAddressEncoder] when type is "ethereum(false)"', () {
      // Arrange
      String actualSerializedType = 'ethereum(false)';

      // Act
      ABlockchainAddressEncoder<ABip32PublicKey> actualAddressEncoder = ABlockchainAddressEncoder.fromSerializedType(actualSerializedType);

      // Assert
      expect(actualAddressEncoder, isA<EthereumAddressEncoder>());
      expect((actualAddressEncoder as EthereumAddressEncoder).skipChecksumBool, false);
    });
  });
}
