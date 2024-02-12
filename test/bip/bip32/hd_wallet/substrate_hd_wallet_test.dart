import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:test/test.dart';

void main() {
  String actualMnemonic = 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage';
  String actualUri = 'shift shed release funny grab acquire fish cannon comic proof quantum cabbage//Alice';

  group('Tests of SubstrateHDWallet.fromUri() (ED25519)', () {
    test('Should [return SubstrateHDWallet] from given mnemonic (ED25519-Polkadot)', () async {
      // Act
      SubstrateHDWallet actualPolkadotWallet = await SubstrateHDWallet.fromUri(
        secretUri: actualMnemonic,
        walletConfig: SubstrateWalletsConfig.polkadotEd25519,
      );

      // Assert
      SubstrateHDWallet expectedPolkadotWallet = SubstrateHDWallet(
        address: '15PbJs4DKpM3yqZB2h48chHh9CgtXMu8af3hYfJ56NxcGDfh',
        walletConfig: SubstrateWalletsConfig.polkadotEd25519,
        privateKey: ED25519PrivateKey(
          metadata: Bip32KeyMetadata(
            depth: 0,
            fingerprint: BigInt.parse('1344436917'),
            parentFingerprint: BigInt.parse('0'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          edPrivateKey: EDPrivateKey.fromBytes(base64Decode('SNUP4gf+pH4VRSXDVkpWpEifS3zz0eXKiQD1NTvZUJM=')),
        ),
        publicKey: ED25519PublicKey(
          metadata: Bip32KeyMetadata(
            depth: 0,
            fingerprint: BigInt.parse('1344436917'),
            parentFingerprint: BigInt.parse('0'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          edPublicKey: EDPublicKey(
            EDPoint(
              curve: Curves.ed25519,
              n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
              x: BigInt.parse('29021442406086584167774021375163838736967527093500686942616965780397496396125'),
              y: BigInt.parse('43115583957353186708676483869570509219130173837349330861786505743438379922320'),
              z: BigInt.parse('5952156733496127290945663030962926212917638045203707780638238813613862174985'),
              t: BigInt.parse('33061071227268966470970327363511845104923370861103369517687119503118790247217'),
            ),
          ),
        ),
        algorithmType: EDAlgorithmType.ed25519,
      );

      expect(actualPolkadotWallet, expectedPolkadotWallet);
    });

    test('Should [return SubstrateHDWallet] from given mnemonic (ED25519-Kusama)', () async {
      // Act
      SubstrateHDWallet actualKusamaWallet = await SubstrateHDWallet.fromUri(
        secretUri: actualMnemonic,
        walletConfig: SubstrateWalletsConfig.kusamaEd25519,
      );

      // Assert
      SubstrateHDWallet expectedKusamaWallet = SubstrateHDWallet(
        address: 'Gxupr926Q6WHxN6qkpBNVpYSAyUdjAAxY9xn2ag269apoAw',
        walletConfig: SubstrateWalletsConfig.kusamaEd25519,
        privateKey: ED25519PrivateKey(
          metadata: Bip32KeyMetadata(
            depth: 0,
            fingerprint: BigInt.parse('1344436917'),
            parentFingerprint: BigInt.parse('0'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          edPrivateKey: EDPrivateKey.fromBytes(base64Decode('SNUP4gf+pH4VRSXDVkpWpEifS3zz0eXKiQD1NTvZUJM=')),
        ),
        publicKey: ED25519PublicKey(
          metadata: Bip32KeyMetadata(
            depth: 0,
            fingerprint: BigInt.parse('1344436917'),
            parentFingerprint: BigInt.parse('0'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          edPublicKey: EDPublicKey(
            EDPoint(
              curve: Curves.ed25519,
              n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
              x: BigInt.parse('29021442406086584167774021375163838736967527093500686942616965780397496396125'),
              y: BigInt.parse('43115583957353186708676483869570509219130173837349330861786505743438379922320'),
              z: BigInt.parse('5952156733496127290945663030962926212917638045203707780638238813613862174985'),
              t: BigInt.parse('33061071227268966470970327363511845104923370861103369517687119503118790247217'),
            ),
          ),
        ),
        algorithmType: EDAlgorithmType.ed25519,
      );

      expect(actualKusamaWallet, expectedKusamaWallet);
    });

    test('Should [return SubstrateHDWallet] from given mnemonic (ED25519-Substrate)', () async {
      // Act
      SubstrateHDWallet actualSubstrateWallet = await SubstrateHDWallet.fromUri(
        secretUri: actualMnemonic,
        walletConfig: SubstrateWalletsConfig.substrateEd25519,
      );

      // Assert
      SubstrateHDWallet expectedSubstrateWallet = SubstrateHDWallet(
        address: '5GTJAXo9U35aYJYf5418UYTYHahEq4LzWAKDPNJiYHw65wxi',
        walletConfig: SubstrateWalletsConfig.substrateEd25519,
        privateKey: ED25519PrivateKey(
          metadata: Bip32KeyMetadata(
            depth: 0,
            fingerprint: BigInt.parse('1344436917'),
            parentFingerprint: BigInt.parse('0'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          edPrivateKey: EDPrivateKey.fromBytes(base64Decode('SNUP4gf+pH4VRSXDVkpWpEifS3zz0eXKiQD1NTvZUJM=')),
        ),
        publicKey: ED25519PublicKey(
          metadata: Bip32KeyMetadata(
            depth: 0,
            fingerprint: BigInt.parse('1344436917'),
            parentFingerprint: BigInt.parse('0'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          edPublicKey: EDPublicKey(
            EDPoint(
              curve: Curves.ed25519,
              n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
              x: BigInt.parse('29021442406086584167774021375163838736967527093500686942616965780397496396125'),
              y: BigInt.parse('43115583957353186708676483869570509219130173837349330861786505743438379922320'),
              z: BigInt.parse('5952156733496127290945663030962926212917638045203707780638238813613862174985'),
              t: BigInt.parse('33061071227268966470970327363511845104923370861103369517687119503118790247217'),
            ),
          ),
        ),
        algorithmType: EDAlgorithmType.ed25519,
      );

      expect(actualSubstrateWallet, expectedSubstrateWallet);
    });
  });

  group('Tests of SubstrateHDWallet.fromUri() (SR25519-mnemonic)', () {
    test('Should [return SubstrateHDWallet] from given mnemonic (SR25519-Polkadot)', () async {
      // Act
      SubstrateHDWallet actualPolkadotWallet = await SubstrateHDWallet.fromUri(
        secretUri: actualMnemonic,
        walletConfig: SubstrateWalletsConfig.polkadotSr25519,
      );

      // Assert
      SubstrateHDWallet expectedPolkadotWallet = SubstrateHDWallet(
        address: '16fuLhS5shuj7XyfCHvkdGGV4qGxKrp3QemA8pNpeyUsAF9c',
        walletConfig: SubstrateWalletsConfig.polkadotSr25519,
        privateKey: SR25519PrivateKey(
          metadata: Bip32KeyMetadata(
            depth: 0,
            fingerprint: BigInt.parse('1344436917'),
            parentFingerprint: BigInt.parse('0'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          key: base64Decode('T638LP9QwSABfXnIrVRkHXSCek2xdRS6f1du8wh9Yg4='),
        ),
        publicKey: SR25519PublicKey(
          metadata: Bip32KeyMetadata(
            depth: 0,
            fingerprint: BigInt.parse('1344436917'),
            parentFingerprint: BigInt.parse('0'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          P: Ristretto255Point(
            curve: Curves.ed25519,
            n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
            x: BigInt.parse('25658527662770975210789208361056684541862228777606229896301360106785728447139'),
            y: BigInt.parse('37342270392816503478332645220587456657909813007080414480351833964484225797756'),
            z: BigInt.parse('24703882922517788272577884574038060260297590592893191924078395042704629471644'),
            t: BigInt.parse('35968659502864795862166773530485119751423490117501100583819542520106122204291'),
          ),
        ),
        algorithmType: EDAlgorithmType.sr25519,
      );

      expect(actualPolkadotWallet, expectedPolkadotWallet);
    });

    test('Should [return SubstrateHDWallet] from given mnemonic (SR25519-Kusama)', () async {
      // Act
      SubstrateHDWallet actualKusamaWallet = await SubstrateHDWallet.fromUri(
        secretUri: actualMnemonic,
        walletConfig: SubstrateWalletsConfig.kusamaSr25519,
      );

      // Assert
      SubstrateHDWallet expectedKusamaWallet = SubstrateHDWallet(
        address: 'JFDrgWteHfBRenb1MgoP4oLMoZYSE55nXsRNBfRagfqis4U',
        walletConfig: SubstrateWalletsConfig.kusamaSr25519,
        privateKey: SR25519PrivateKey(
          metadata: Bip32KeyMetadata(
            depth: 0,
            fingerprint: BigInt.parse('1344436917'),
            parentFingerprint: BigInt.parse('0'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          key: base64Decode('T638LP9QwSABfXnIrVRkHXSCek2xdRS6f1du8wh9Yg4='),
        ),
        publicKey: SR25519PublicKey(
          metadata: Bip32KeyMetadata(
            depth: 0,
            fingerprint: BigInt.parse('1344436917'),
            parentFingerprint: BigInt.parse('0'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          P: Ristretto255Point(
            curve: Curves.ed25519,
            n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
            x: BigInt.parse('25658527662770975210789208361056684541862228777606229896301360106785728447139'),
            y: BigInt.parse('37342270392816503478332645220587456657909813007080414480351833964484225797756'),
            z: BigInt.parse('24703882922517788272577884574038060260297590592893191924078395042704629471644'),
            t: BigInt.parse('35968659502864795862166773530485119751423490117501100583819542520106122204291'),
          ),
        ),
        algorithmType: EDAlgorithmType.sr25519,
      );

      expect(actualKusamaWallet, expectedKusamaWallet);
    });

    test('Should [return SubstrateHDWallet] from given mnemonic (SR25519-Substrate)', () async {
      // Act
      SubstrateHDWallet actualSubstrateWallet = await SubstrateHDWallet.fromUri(
        secretUri: actualMnemonic,
        walletConfig: SubstrateWalletsConfig.substrateSr25519,
      );

      // Assert
      SubstrateHDWallet expectedSubstrateWallet = SubstrateHDWallet(
        address: '5HjcCNB21veFfzy9EeskV7SLDDHJdZFuLA2fyXPU6tTLyjyL',
        walletConfig: SubstrateWalletsConfig.substrateSr25519,
        privateKey: SR25519PrivateKey(
          metadata: Bip32KeyMetadata(
            depth: 0,
            fingerprint: BigInt.parse('1344436917'),
            parentFingerprint: BigInt.parse('0'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          key: base64Decode('T638LP9QwSABfXnIrVRkHXSCek2xdRS6f1du8wh9Yg4='),
        ),
        publicKey: SR25519PublicKey(
          metadata: Bip32KeyMetadata(
            depth: 0,
            fingerprint: BigInt.parse('1344436917'),
            parentFingerprint: BigInt.parse('0'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          P: Ristretto255Point(
            curve: Curves.ed25519,
            n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
            x: BigInt.parse('25658527662770975210789208361056684541862228777606229896301360106785728447139'),
            y: BigInt.parse('37342270392816503478332645220587456657909813007080414480351833964484225797756'),
            z: BigInt.parse('24703882922517788272577884574038060260297590592893191924078395042704629471644'),
            t: BigInt.parse('35968659502864795862166773530485119751423490117501100583819542520106122204291'),
          ),
        ),
        algorithmType: EDAlgorithmType.sr25519,
      );

      expect(actualSubstrateWallet, expectedSubstrateWallet);
    });
  });

  group('Tests of SubstrateHDWallet.fromUri() (SR25519-uri)', () {
    test('Should [return SubstrateHDWallet] from given mnemonic (SR25519-Polkadot)', () async {
      // Act
      SubstrateHDWallet actualPolkadotWallet = await SubstrateHDWallet.fromUri(
        secretUri: actualUri,
        walletConfig: SubstrateWalletsConfig.polkadotSr25519,
      );

      // Assert
      SubstrateHDWallet expectedPolkadotWallet = SubstrateHDWallet(
        address: '13EiLKpSaWLZVXKPuh8Fjkzph9urbir695R8qgWE6XHYtCvt',
        walletConfig: SubstrateWalletsConfig.polkadotSr25519,
        privateKey: SR25519PrivateKey(
          metadata: Bip32KeyMetadata(
            depth: 1,
            chainCode: base64Decode('0PuuLRtj1ULEpcqIUms1XWTA/0LBtKPFeathnL61lOc='),
            fingerprint: BigInt.parse('3180547162'),
            parentFingerprint: BigInt.parse('1344436917'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          key: base64Decode('EPLvbSTOy3rzR5tbOqqTXGsqUHjlWB9fApOL8SKQCQg='),
        ),
        publicKey: SR25519PublicKey(
          metadata: Bip32KeyMetadata(
            depth: 1,
            chainCode: base64Decode('0PuuLRtj1ULEpcqIUms1XWTA/0LBtKPFeathnL61lOc='),
            fingerprint: BigInt.parse('3180547162'),
            parentFingerprint: BigInt.parse('1344436917'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          P: Ristretto255Point(
            curve: Curves.ed25519,
            n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
            x: BigInt.parse('57647807138731086854719147428534364527408973440674997323586474929486297215498'),
            y: BigInt.parse('56928488956129998624248973747159938508280141385422357433380193442735588740711'),
            z: BigInt.parse('39660975461929599524771975860800330231663739857778634655603332803029162849118'),
            t: BigInt.parse('29393175147761522875492033973189436752932002509214848438040941757352914404314'),
          ),
        ),
        algorithmType: EDAlgorithmType.sr25519,
      );

      expect(actualPolkadotWallet, expectedPolkadotWallet);
    });

    test('Should [return SubstrateHDWallet] from given mnemonic (SR25519-Kusama)', () async {
      // Act
      SubstrateHDWallet actualKusamaWallet = await SubstrateHDWallet.fromUri(
        secretUri: actualUri,
        walletConfig: SubstrateWalletsConfig.kusamaSr25519,
      );

      // Assert
      SubstrateHDWallet expectedKusamaWallet = SubstrateHDWallet(
        address: 'Ep2rJuFM661oe8KiktJVZXfz8CSi678WxXQ53nq2EUXSxU4',
        walletConfig: SubstrateWalletsConfig.kusamaSr25519,
        privateKey: SR25519PrivateKey(
          metadata: Bip32KeyMetadata(
            depth: 1,
            chainCode: base64Decode('0PuuLRtj1ULEpcqIUms1XWTA/0LBtKPFeathnL61lOc='),
            fingerprint: BigInt.parse('3180547162'),
            parentFingerprint: BigInt.parse('1344436917'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          key: base64Decode('EPLvbSTOy3rzR5tbOqqTXGsqUHjlWB9fApOL8SKQCQg='),
        ),
        publicKey: SR25519PublicKey(
          metadata: Bip32KeyMetadata(
            depth: 1,
            chainCode: base64Decode('0PuuLRtj1ULEpcqIUms1XWTA/0LBtKPFeathnL61lOc='),
            fingerprint: BigInt.parse('3180547162'),
            parentFingerprint: BigInt.parse('1344436917'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          P: Ristretto255Point(
            curve: Curves.ed25519,
            n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
            x: BigInt.parse('57647807138731086854719147428534364527408973440674997323586474929486297215498'),
            y: BigInt.parse('56928488956129998624248973747159938508280141385422357433380193442735588740711'),
            z: BigInt.parse('39660975461929599524771975860800330231663739857778634655603332803029162849118'),
            t: BigInt.parse('29393175147761522875492033973189436752932002509214848438040941757352914404314'),
          ),
        ),
        algorithmType: EDAlgorithmType.sr25519,
      );

      expect(actualKusamaWallet, expectedKusamaWallet);
    });

    test('Should [return SubstrateHDWallet] from given mnemonic (SR25519-Substrate)', () async {
      // Act
      SubstrateHDWallet actualSubstrateWallet = await SubstrateHDWallet.fromUri(
        secretUri: actualUri,
        walletConfig: SubstrateWalletsConfig.substrateSr25519,
      );

      // Assert
      SubstrateHDWallet expectedSubstrateWallet = SubstrateHDWallet(
        address: '5EJRBzZNij563zJsx45FbcAfqXvCuRHx4agegPWsYSG2hsX5',
        walletConfig: SubstrateWalletsConfig.substrateSr25519,
        privateKey: SR25519PrivateKey(
          metadata: Bip32KeyMetadata(
            depth: 1,
            chainCode: base64Decode('0PuuLRtj1ULEpcqIUms1XWTA/0LBtKPFeathnL61lOc='),
            fingerprint: BigInt.parse('3180547162'),
            parentFingerprint: BigInt.parse('1344436917'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          key: base64Decode('EPLvbSTOy3rzR5tbOqqTXGsqUHjlWB9fApOL8SKQCQg='),
        ),
        publicKey: SR25519PublicKey(
          metadata: Bip32KeyMetadata(
            depth: 1,
            chainCode: base64Decode('0PuuLRtj1ULEpcqIUms1XWTA/0LBtKPFeathnL61lOc='),
            fingerprint: BigInt.parse('3180547162'),
            parentFingerprint: BigInt.parse('1344436917'),
            masterFingerprint: BigInt.parse('1344436917'),
          ),
          P: Ristretto255Point(
            curve: Curves.ed25519,
            n: BigInt.parse('7237005577332262213973186563042994240857116359379907606001950938285454250989'),
            x: BigInt.parse('57647807138731086854719147428534364527408973440674997323586474929486297215498'),
            y: BigInt.parse('56928488956129998624248973747159938508280141385422357433380193442735588740711'),
            z: BigInt.parse('39660975461929599524771975860800330231663739857778634655603332803029162849118'),
            t: BigInt.parse('29393175147761522875492033973189436752932002509214848438040941757352914404314'),
          ),
        ),
        algorithmType: EDAlgorithmType.sr25519,
      );

      expect(actualSubstrateWallet, expectedSubstrateWallet);
    });
  });
}
