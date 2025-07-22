import 'dart:typed_data';

class Int32Utils {
  static const int _mask5Bits = 0x1F;
  static const int _mask32Bits = 0xFFFFFFFF;

  static const List<int> _mask32BitsList = <int>[
    0xFFFFFFFF,
    0x7FFFFFFF,
    0x3FFFFFFF,
    0x1FFFFFFF,
    0x0FFFFFFF,
    0x07FFFFFF,
    0x03FFFFFF,
    0x01FFFFFF,
    0x00FFFFFF,
    0x007FFFFF,
    0x003FFFFF,
    0x001FFFFF,
    0x000FFFFF,
    0x0007FFFF,
    0x0003FFFF,
    0x0001FFFF,
    0x0000FFFF,
    0x00007FFF,
    0x00003FFF,
    0x00001FFF,
    0x00000FFF,
    0x000007FF,
    0x000003FF,
    0x000001FF,
    0x000000FF,
    0x0000007F,
    0x0000003F,
    0x0000001F,
    0x0000000F,
    0x00000007,
    0x00000003,
    0x00000001,
    0x00000000
  ];

  static void pack(int x, Uint8List outputUint8List, int offset, Endian endian) {
    ByteData.view(outputUint8List.buffer, outputUint8List.offsetInBytes, outputUint8List.length).setUint32(offset, x, endian);
  }

  static int shiftLeft(int chunk32Bits, int shiftValue) {
    int maskedN = shiftValue & _mask5Bits;
    int maskedX = chunk32Bits & _mask32BitsList[maskedN];
    return (maskedX << maskedN) & _mask32Bits;
  }

  static int shiftRight(int chunk32Bits, int shiftValue) {
    int maskedShiftValue = shiftValue & _mask5Bits;
    return chunk32Bits >> maskedShiftValue;
  }

  static int rotateLeft(int chunk32Bits, int offset) {
    int maskedOffset = offset & _mask5Bits;
    return shiftLeft(chunk32Bits, maskedOffset) | (chunk32Bits >> (32 - maskedOffset));
  }

  static int rotateRight(int chunk32Bits, int offset) {
    int maskedOffset = offset & _mask5Bits;
    return (chunk32Bits >> maskedOffset) | shiftLeft(chunk32Bits, 32 - maskedOffset);
  }

  static int unpack(Uint8List inputUint8List, int offset, Endian endian) {
    ByteData byteData = ByteData.view(inputUint8List.buffer, inputUint8List.offsetInBytes, inputUint8List.length);
    return byteData.getUint32(offset, endian);
  }
}
