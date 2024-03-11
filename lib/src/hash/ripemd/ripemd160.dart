import 'package:cryptography_utils/src/hash/ripemd/a_ripemd_base.dart';

/// [Ripemd160] is an implementation of RIPEMD-160  algorithm which is a secure hash function
/// producing a 160-bit output, used for secure data processing and digital signatures.
class Ripemd160 extends ARipemdBase {
  Ripemd160() : super(20);

  @override
  @protected
  void processChunk(List<int> chunk) {
    int al = state[0];
    int bl = state[1];
    int cl = state[2];
    int dl = state[3];
    int el = state[4];
    int ar = al;
    int br = bl;
    int cr = cl;
    int dr = dl;
    int er = el;

    for (int i = 0; i < 80; i++) {
      int t = BinaryUtils.add32(al, chunk[ARipemdBase.zl[i]]);
      t = BinaryUtils.add32(t, transform(i, bl, cl, dl));
      t = BinaryUtils.rotl32(t, ARipemdBase.sl[i]);
      t = BinaryUtils.add32(t, el);
      al = el;
      el = dl;
      dl = BinaryUtils.rotl32(cl, 10);
      cl = bl;
      bl = t;

      t = BinaryUtils.add32(ar, chunk[ARipemdBase.zr[i]]);
      t = t + transform80bits(i, br, cr, dr);
      t = BinaryUtils.rotl32(t, ARipemdBase.sr[i]);
      t = BinaryUtils.add32(t, er);
      ar = er;
      er = dr;
      dr = BinaryUtils.rotl32(cr, 10);
      cr = br;
      br = t;
    }

    int t = BinaryUtils.add32(BinaryUtils.add32(state[1], cl), dr);
    state[1] = BinaryUtils.add32(BinaryUtils.add32(state[2], dl), er);
    state[2] = BinaryUtils.add32(BinaryUtils.add32(state[3], el), ar);
    state[3] = BinaryUtils.add32(BinaryUtils.add32(state[4], al), br);
    state[4] = BinaryUtils.add32(BinaryUtils.add32(state[0], bl), cr);
    state[0] = t;
  }
}
