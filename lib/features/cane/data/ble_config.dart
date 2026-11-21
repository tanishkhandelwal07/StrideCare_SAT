/// Proposed v1 firmware contract. See docs/CANE_BLE_SPEC.md.
abstract final class CaneGatt {
  static const service = '30f30000-9713-49a7-9530-2554e9ee0000';
  static const telemetry = '30f30000-9713-49a7-9530-2554e9ee0001';
  static const vibration = '30f30000-9713-49a7-9530-2554e9ee0002';
  static const fall = "30f30000-9713-49a7-9530-2554e9ee0003";
  static const info = "30f30000-9713-49a7-9530-2554e9ee0004";
  static const sync = "30f30000-9713-49a7-9530-2554e9ee0005";
}
