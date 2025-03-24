import 'dart:typed_data';

import 'package:cryptography_utils/src/hash/sha/sha256/sha256.dart';
import 'package:cryptography_utils/src/utils/bytes_utils.dart';
import 'package:cryptography_utils/src/utils/secure_random.dart';

class EntropyGenerator {
  final Uint8List imageBytes;
  late final Uint8List entropy;
  late final Uint8List _imageBytesNoHeader;

  EntropyGenerator(this.imageBytes) {
    _imageBytesNoHeader = _extractHeader();
    entropy = generateEntropyFromImage();
  }

  Uint8List generateEntropyFromImage() {
    Uint8List imageEntropy = Sha256().convert(_imageBytesNoHeader).byteList;
    Uint8List machineEntropy = _generateMachineEntropy(imageEntropy.length);
    Uint8List mergedEntropy = _mergeEntropy(imageEntropy, machineEntropy);
    Uint8List truncated256bitEntropy = BytesUtils.truncate(input: mergedEntropy, length: 32);
    return truncated256bitEntropy;
  }

  Uint8List _mergeEntropy(Uint8List imageEntropy, Uint8List machineEntropy) {
    Uint8List mergedEntropy = BytesUtils.performXor(imageEntropy, machineEntropy);
    return mergedEntropy;
  }

  Uint8List _extractHeader() {
    // 0xFF 0xDA bytes define Start Of Scan (actual image) https://en.wikipedia.org/wiki/JPEG#Syntax_and_structure
    // They are followed by what seems to be 10 additional header bytes
    // Last header bytes: 0xFF 0xDA 0x00 0x0C 0x03 0x01 0x00 0x02 0x11 0x03 0x11 0x00 0x3F 0x00

    int byteIndex = 2;
    while (byteIndex < imageBytes.length - 2) {
      if (imageBytes[byteIndex] == 0xFF && imageBytes[byteIndex + 1] == 0xDA) {
        imageBytes.sublist(byteIndex + 14);
        break;
      }
      byteIndex++;
    }
    return imageBytes.sublist(byteIndex + 14);
  }

  Uint8List _generateMachineEntropy(int length) {
    Uint8List machineEntropy = SecureRandom.getBytes(length: length, max: 255);
    return machineEntropy;
  }
}
