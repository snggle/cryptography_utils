import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  Mnemonic mnemonic = Mnemonic.fromMnemonicPhrase(
      'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield');

  group('Tests of LegacyHDWallet.fromMnemonic()', () {
    test('Should [return LegacyHDWallet] from given mnemonic (BIP44-Bitcoin)', () async {
      // Act
      LegacyHDWallet actualBitcoinBip44Wallet = await LegacyHDWallet.fromMnemonic(
        mnemonic: mnemonic,
        walletConfig: Bip44WalletsConfig.bitcoin,
        derivationPath: LegacyDerivationPath.parse("m/44'/0'/0'/0/0"),
      );

      // Assert
      Bip32KeyMetadata expectedBip32Metadata = Bip32KeyMetadata(
        depth: 5,
        shiftedIndex: 0,
        fingerprint: BigInt.parse('220462739'),
        parentFingerprint: BigInt.parse('541880847'),
        masterFingerprint: BigInt.parse('83580899'),
        chainCode: base64Decode('rEcUq915xZMcSVN9UIfhWIf7c+cb9fURwnXSJ59fbhs='),
      );

      LegacyHDWallet expectedBitcoinBip44Wallet = LegacyHDWallet(
        address: '12CUuS1w48dmLqug3sQeZGXhM6ziyLdDFR',
        walletConfig: Bip44WalletsConfig.bitcoin,
        privateKey: Secp256k1PrivateKey(
          ecPrivateKey: ECPrivateKey(
            CurvePoints.generatorSecp256k1,
            BigInt.parse('82377503398124971005475108599523902661393087907602410456433373035270068286106'),
          ),
          metadata: expectedBip32Metadata,
        ),
        publicKey: Secp256k1PublicKey(
          ecPublicKey: ECPublicKey(
            CurvePoints.generatorSecp256k1,
            ECPoint(
              curve: Curves.secp256k1,
              n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
              x: BigInt.parse('38336877429777144060267786813855742566762755003810222330370030177500553175552'),
              y: BigInt.parse('43563831752869961512099662435070760564842488811079803779798870455459619618648'),
              z: BigInt.parse('84221606303351351252384011276733806130312533127115701665238461934963837834470'),
            ),
          ),
          metadata: expectedBip32Metadata,
        ),
        derivationPath: LegacyDerivationPath.parse("m/44'/0'/0'/0/0"),
      );

      expect(actualBitcoinBip44Wallet, expectedBitcoinBip44Wallet);
    });

    test('Should [return LegacyHDWallet] from given mnemonic (BIP49-Bitcoin)', () async {
      // Act
      LegacyHDWallet actualBitcoinBip49Wallet = await LegacyHDWallet.fromMnemonic(
        mnemonic: mnemonic,
        walletConfig: Bip49WalletsConfig.bitcoin,
        derivationPath: LegacyDerivationPath.parse("m/49'/0'/0'/0/0"),
      );

      // Assert
      Bip32KeyMetadata expectedBip32Metadata = Bip32KeyMetadata(
        depth: 5,
        shiftedIndex: 0,
        fingerprint: BigInt.parse('2009194743'),
        parentFingerprint: BigInt.parse('3366442085'),
        masterFingerprint: BigInt.parse('83580899'),
        chainCode: base64Decode('dD+m4pyYe3edlY9ZDNDpe370dwMmGNF2ihkMDXjYSpY='),
      );

      LegacyHDWallet expectedBitcoinBip49Wallet = LegacyHDWallet(
        address: '38BaaMYeUR32tptWPcfLiuZwdkq1iHy7mW',
        walletConfig: Bip49WalletsConfig.bitcoin,
        privateKey: Secp256k1PrivateKey(
          ecPrivateKey: ECPrivateKey(
            CurvePoints.generatorSecp256k1,
            BigInt.parse('94791086327829028717275008054464607695206537392279157300063391421050953013739'),
          ),
          metadata: expectedBip32Metadata,
        ),
        publicKey: Secp256k1PublicKey(
          ecPublicKey: ECPublicKey(
            CurvePoints.generatorSecp256k1,
            ECPoint(
              curve: Curves.secp256k1,
              n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
              x: BigInt.parse('45598833024007063412331531275003851810927383922680420932075021036000176892257'),
              y: BigInt.parse('52075805451846365275495005964097842681620553159632658097877797800509943385562'),
              z: BigInt.parse('11902898874332229604673834019199903475888972972060602920606280067238874780442'),
            ),
          ),
          metadata: expectedBip32Metadata,
        ),
        derivationPath: LegacyDerivationPath.parse("m/49'/0'/0'/0/0"),
      );

      expect(actualBitcoinBip49Wallet, expectedBitcoinBip49Wallet);
    });

    test('Should [return LegacyHDWallet] from given mnemonic (BIP84-Bitcoin)', () async {
      // Act
      LegacyHDWallet actualBitcoinBip84Wallet = await LegacyHDWallet.fromMnemonic(
        mnemonic: mnemonic,
        walletConfig: Bip84WalletsConfig.bitcoin,
        derivationPath: LegacyDerivationPath.parse("m/84'/0'/0'/0/0"),
      );

      // Assert
      Bip32KeyMetadata expectedBip32Metadata = Bip32KeyMetadata(
        depth: 5,
        shiftedIndex: 0,
        fingerprint: BigInt.parse('3785737267'),
        parentFingerprint: BigInt.parse('4177480418'),
        masterFingerprint: BigInt.parse('83580899'),
        chainCode: base64Decode('HmhuNs2LO3+/SpMIb4FCOCRlS5Ym+ACIprpAAmG4zMI='),
      );

      LegacyHDWallet expectedBitcoinBip84Wallet = LegacyHDWallet(
        address: 'bc1quxjugvagpv4kz5hdkh7x0qklarw5akdk2sg0wp',
        walletConfig: Bip84WalletsConfig.bitcoin,
        privateKey: Secp256k1PrivateKey(
          ecPrivateKey: ECPrivateKey(
            CurvePoints.generatorSecp256k1,
            BigInt.parse('104431983138007662112969845964787088318479940099811565105163559790396390283107'),
          ),
          metadata: expectedBip32Metadata,
        ),
        publicKey: Secp256k1PublicKey(
          ecPublicKey: ECPublicKey(
            CurvePoints.generatorSecp256k1,
            ECPoint(
              curve: Curves.secp256k1,
              n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
              x: BigInt.parse('76703126420722322007634345723463650715654444727861292197619275780698078484198'),
              y: BigInt.parse('74654274679389979607131077993714677055519561275235266585538223878569670773020'),
              z: BigInt.parse('40734431342056095760694605795848451157672234281365399275614292579983211792826'),
            ),
          ),
          metadata: expectedBip32Metadata,
        ),
        derivationPath: LegacyDerivationPath.parse("m/84'/0'/0'/0/0"),
      );

      expect(actualBitcoinBip84Wallet, expectedBitcoinBip84Wallet);
    });

    test('Should [return LegacyHDWallet] from given mnemonic (BIP44-Cosmos)', () async {
      // Act
      LegacyHDWallet actualCosmosWallet = await LegacyHDWallet.fromMnemonic(
        mnemonic: mnemonic,
        walletConfig: Bip44WalletsConfig.cosmos,
        derivationPath: LegacyDerivationPath.parse("m/44'/118'/0'/0/0"),
      );

      // Assert
      Bip32KeyMetadata expectedBip32Metadata = Bip32KeyMetadata(
        depth: 5,
        shiftedIndex: 0,
        fingerprint: BigInt.parse('2889905688'),
        parentFingerprint: BigInt.parse('58474422'),
        masterFingerprint: BigInt.parse('83580899'),
        chainCode: base64Decode('atgf2JWMxW014Hby5ccSn5NlRKQvIV2jvsdtcN3Eb8I='),
      );

      LegacyHDWallet expectedCosmosWallet = LegacyHDWallet(
        address: 'cosmos143q8vxpvuykt9pq50e6hng9s38vmy844rgut0t',
        walletConfig: Bip44WalletsConfig.cosmos,
        privateKey: Secp256k1PrivateKey(
          ecPrivateKey: ECPrivateKey(
            CurvePoints.generatorSecp256k1,
            BigInt.parse('25933686250415448129536663355227060923413846494721047098076326567395973050293'),
          ),
          metadata: expectedBip32Metadata,
        ),
        publicKey: Secp256k1PublicKey(
          ecPublicKey: ECPublicKey(
            CurvePoints.generatorSecp256k1,
            ECPoint(
              curve: Curves.secp256k1,
              n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
              x: BigInt.parse('103541830980023606809613093633067363502594290705821036222890728111110906420509'),
              y: BigInt.parse('75808906644622006047938879719654783679105512040910575915102508326553703647166'),
              z: BigInt.parse('3190226348536498292494465017020441737630476122313049345633869118655223224149'),
            ),
          ),
          metadata: expectedBip32Metadata,
        ),
        derivationPath: LegacyDerivationPath.parse("m/44'/118'/0'/0/0"),
      );

      expect(actualCosmosWallet, expectedCosmosWallet);
    });

    test('Should [return LegacyHDWallet] from given mnemonic (BIP44-Ethereum)', () async {
      // Act
      LegacyHDWallet actualEthereumWallet = await LegacyHDWallet.fromMnemonic(
        mnemonic: mnemonic,
        walletConfig: Bip44WalletsConfig.ethereum,
        derivationPath: LegacyDerivationPath.parse("m/44'/60'/0'/0/0"),
      );

      // Assert
      Bip32KeyMetadata expectedBip32Metadata = Bip32KeyMetadata(
        depth: 5,
        shiftedIndex: 0,
        fingerprint: BigInt.parse('2837893204'),
        parentFingerprint: BigInt.parse('162080603'),
        masterFingerprint: BigInt.parse('83580899'),
        chainCode: base64Decode('YsN74zJ6p9/kjsFCM5UUBq470XR3CEssHXyawdn7xBw='),
      );

      LegacyHDWallet expectedEthereumWallet = LegacyHDWallet(
        address: '0x50e10257924889818aA729c6EDfa02524b32Edb9',
        walletConfig: Bip44WalletsConfig.ethereum,
        privateKey: Secp256k1PrivateKey(
          ecPrivateKey: ECPrivateKey(
            CurvePoints.generatorSecp256k1,
            BigInt.parse('91850346642365090382529827989594437164777469345439968194889143349494450093883'),
          ),
          metadata: expectedBip32Metadata,
        ),
        publicKey: Secp256k1PublicKey(
          ecPublicKey: ECPublicKey(
            CurvePoints.generatorSecp256k1,
            ECPoint(
              curve: Curves.secp256k1,
              n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
              x: BigInt.parse('49844093485842753019501723164709087800134847594852664670182601545797061237061'),
              y: BigInt.parse('102584019795063234624860865414832132871049165551248963828805190591824528686504'),
              z: BigInt.parse('33112508886275853310422687256511308836721055527980470378416551104097868981749'),
            ),
          ),
          metadata: expectedBip32Metadata,
        ),
        derivationPath: LegacyDerivationPath.parse("m/44'/60'/0'/0/0"),
      );

      expect(actualEthereumWallet, expectedEthereumWallet);
    });

    test('Should [return LegacyHDWallet] from given mnemonic (BIP44-Kira)', () async {
      // Act
      LegacyHDWallet actualKiraWallet = await LegacyHDWallet.fromMnemonic(
        mnemonic: mnemonic,
        walletConfig: Bip44WalletsConfig.kira,
        derivationPath: LegacyDerivationPath.parse("m/44'/118'/0'/0/0"),
      );

      // Assert
      Bip32KeyMetadata expectedBip32Metadata = Bip32KeyMetadata(
        depth: 5,
        shiftedIndex: 0,
        fingerprint: BigInt.parse('2889905688'),
        parentFingerprint: BigInt.parse('58474422'),
        masterFingerprint: BigInt.parse('83580899'),
        chainCode: base64Decode('atgf2JWMxW014Hby5ccSn5NlRKQvIV2jvsdtcN3Eb8I='),
      );

      LegacyHDWallet expectedKiraWallet = LegacyHDWallet(
        address: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
        walletConfig: Bip44WalletsConfig.kira,
        privateKey: Secp256k1PrivateKey(
          ecPrivateKey: ECPrivateKey(
            CurvePoints.generatorSecp256k1,
            BigInt.parse('25933686250415448129536663355227060923413846494721047098076326567395973050293'),
          ),
          metadata: expectedBip32Metadata,
        ),
        publicKey: Secp256k1PublicKey(
          ecPublicKey: ECPublicKey(
            CurvePoints.generatorSecp256k1,
            ECPoint(
              curve: Curves.secp256k1,
              n: BigInt.parse('115792089237316195423570985008687907852837564279074904382605163141518161494337'),
              x: BigInt.parse('103541830980023606809613093633067363502594290705821036222890728111110906420509'),
              y: BigInt.parse('75808906644622006047938879719654783679105512040910575915102508326553703647166'),
              z: BigInt.parse('3190226348536498292494465017020441737630476122313049345633869118655223224149'),
            ),
          ),
          metadata: expectedBip32Metadata,
        ),
        derivationPath: LegacyDerivationPath.parse("m/44'/118'/0'/0/0"),
      );

      expect(actualKiraWallet, expectedKiraWallet);
    });

    test('Should [return LegacyHDWallet] from given mnemonic (BIP44-Solana)', () async {
      // Act
      LegacyHDWallet actualSolanaWallet = await LegacyHDWallet.fromMnemonic(
        mnemonic: mnemonic,
        walletConfig: Bip44WalletsConfig.solana,
        derivationPath: LegacyDerivationPath.parse("m/44'/501'/0'"),
      );

      // Assert
      Bip32KeyMetadata expectedBip32Metadata = Bip32KeyMetadata(
        depth: 3,
        shiftedIndex: 2147483648,
        fingerprint: BigInt.parse('2293503694'),
        parentFingerprint: BigInt.parse('3373575796'),
        masterFingerprint: BigInt.parse('2882279341'),
        chainCode: base64Decode('+ZGw7L105N54Uwwvz4mMpJ6iNJj7xumWTKKCh8QAgIY='),
      );

      LegacyHDWallet expectedSolanaWallet = LegacyHDWallet(
        address: '9hhbpdfqH2xaNhr4Lrd6JsAsmhsMJoou6aTv9K7MC7G6',
        walletConfig: Bip44WalletsConfig.solana,
        privateKey: ED25519PrivateKey(
          metadata: expectedBip32Metadata,
          edPrivateKey: EDPrivateKey.fromBytes(base64Decode('R9I6Ttyga6IgJLNgZPIR0Sq5oCyrujJiWI3ngJn8NuU=')),
        ),
        publicKey: ED25519PublicKey(
          metadata: expectedBip32Metadata,
          edPublicKey: EDPublicKey(
            EDPoint(
              curve: Curves.ed25519,
              n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
              x: BigInt.parse('44770412612249132879508693710199042699271465674024261288602292914024751467771'),
              y: BigInt.parse('9071192539003680880021133333155815940615935403600658841594844653366853384648'),
              z: BigInt.parse('215655415489707601689906281986627164961686488479408878249048443374796070278'),
              t: BigInt.parse('55926202586167076010672118601058589559146741453778469146658296279768153697900'),
            ),
          ),
        ),
        derivationPath: LegacyDerivationPath.parse("m/44'/501'/0'"),
      );

      expect(actualSolanaWallet, expectedSolanaWallet);
    });
  });
}
