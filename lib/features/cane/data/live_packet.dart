import 'dart:typed_data';

class LivePacket {
  const LivePacket(
    this.ms,
    this.flags,
    this.loadTenths,
    this.steps,
    this.cadence,
    this.gait,
  );
  final int ms, flags, loadTenths, steps, cadence, gait;
  Uint8List encode() {
    final b = ByteData(11);
    b.setUint32(0, ms, Endian.little);
    b.setUint8(4, flags);
    b.setInt16(5, loadTenths, Endian.little);
    b.setUint16(7, steps, Endian.little);
    b.setUint8(9, cadence);
    b.setUint8(10, gait);
    return b.buffer.asUint8List();
  }
}

class LivePacketParser {
  int dropped = 0;
  LivePacket? parse(List<int> bytes) {
    if (bytes.length == 11 && bytes.every((v) => v >= 0 && v <= 255)) {
      final b = ByteData.sublistView(Uint8List.fromList(bytes));
      final p = LivePacket(
        b.getUint32(0, Endian.little),
        bytes[4],
        b.getInt16(5, Endian.little),
        b.getUint16(7, Endian.little),
        bytes[9],
        bytes[10],
      );
      if (p.flags <= 3 &&
          p.loadTenths >= 0 &&
          p.loadTenths <= 30000 &&
          p.cadence <= 240 &&
          p.gait <= 100) {
        return p;
      }
    }
    dropped++;
    return null;
  }
}
