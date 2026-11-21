import 'package:flutter_test/flutter_test.dart';
import 'package:stridecare/features/cane/data/live_packet.dart';

void main() {
  const bytes = [0x78, 0x56, 0x34, 0x12, 1, 0xb0, 4, 0xff, 0xff, 76, 91];
  test('v1 little endian wire fixture round trips', () {
    final p = LivePacketParser().parse(bytes)!;
    expect(
      [p.ms, p.flags, p.loadTenths, p.steps, p.cadence, p.gait],
      [0x12345678, 1, 1200, 65535, 76, 91],
    );
    expect(p.encode(), bytes);
  });
  test('malformed samples are counted and dropped', () {
    final parser = LivePacketParser();
    for (final invalid in [
      bytes.sublist(1),
      [...bytes, 0],
      [...bytes]..[4] = 4,
      [...bytes]..[6] = 255,
      [...bytes]..[9] = 241,
      [...bytes]..[10] = 101,
    ]) {
      expect(parser.parse(invalid), isNull);
    }
    expect(parser.dropped, 6);
    expect(parser.parse(bytes), isNotNull);
  });
}
