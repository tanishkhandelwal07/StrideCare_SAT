# StrideCare cane protocol v1

Proposed firmware contract. All multibyte integers use little-endian byte order. Advertise the service UUID and a short StrideCare name. Require a bonded, encrypted connection before reading identifiable information, subscribing to data or writing commands. Firmware should require physical confirmation on the module for a new bond.

Use custom UUIDs of the form `30f30000-9713-49a7-9530-2554e9eeXXXX`. The service ends in 0000. Standard Battery Service 180F exposes Battery Level 2A19, read and notify, one unsigned byte from 0 to 100.

| Suffix | Characteristic | Operations and payload |
| --- | --- | --- |
| 0001 | Live Data | Notify exactly 11 bytes at 10 Hz. See offsets below. |
| 0002 | Vibration | Write without response. Two bytes: pattern (1 gentle feedback, 2 test) and intensity 1–100. Firmware limits each command to a brief pulse. |
| 0003 | Fall Event | Indicate preferred, notify as fallback. Eight bytes: uint32 boot ID and uint32 event uptime in ms. Use serial, boot ID and uptime for deduplication. |
| 0004 | Device Info | Read 18 bytes: major and minor protocol version, three firmware version bytes, 8 printable ASCII serial bytes, uint32 calibration ID, reserved zero byte. Refuse incompatible major versions. |
| 0005 | Sync | Write with response and indicate replies. Implement the record exchange below. |

| Live offset | Type | Meaning |
| --- | --- | --- |
| 0 | uint32 | Monotonic milliseconds since boot, wraps modulo 2^32 |
| 4 | uint8 | Bit 0 grip, bit 1 fall detected. Reserved bits zero. Fall Event repeats the original detection uptime. |
| 5 | int16 | Cane tip support load in tenths of a newton, valid 0–30000. Clamp negative tare noise in firmware. |
| 7 | uint16 | Cumulative steps modulo 65536 |
| 9 | uint8 | Cadence in steps/min, 0–240 |
| 10 | uint8 | Rhythm regularity code 0–100, estimated regularity = code / 100 |

Use the default ATT MTU 23. Each notification or write fits 20 bytes. Reject malformed lengths, reserved flags and values outside the ranges above. A step rollover is distinct from a reboot. Device Info serial is stable across reconnects. Boot ID changes at reboot. A hardware packet capture is still needed to confirm these fixtures.

## Buffered record exchange

All requests begin with a one-byte opcode. Serialize requests, retry the same record on timeout. CLOCK (01 + int64 UTC epoch ms) returns 81 + uint32 boot ID + uint32 uptime sampled at receipt. Keep timestamp anchors for each boot, including uptime wrap count. LIST (02 + uint64 exclusive cursor, zero to start) returns 82 + uint64 next record ID, zero at end. IDs increase for the life of the serial. FETCH (03 + uint64 ID) returns three ordered indications for the same request: 83 + uint64 ID + uint32 boot ID + uint32 start uptime + uint16 wrap count; 84 + uint64 ID + uint32 duration ms + uint32 steps + uint8 mean cadence + uint8 gait code; 85 + uint64 ID + uint16 mean load + uint16 peak load + uint32 calibration ID. Loads use tenths of a newton. ACK (04 + uint64 ID) returns 86 + uint64 ID after removal; repeated ACK succeeds. Errors use FF + request opcode + reason (1 unknown record, 2 busy, 3 invalid request). Reserve new opcodes for extensions.

Persist the full record transactionally before ACK. Use (serial, record ID) as its key. Retain unsynchronized records across resets. Convert uptime using anchors for the same boot. Old records without a reliable UTC anchor remain pending. Use local time only for display.

## Operating limits

Live samples require a connection and a running receiver. When the phone cannot receive them, firmware buffering is the recovery path. Android background collection requires a connected-device foreground service and visible notification. iOS background delivery and restoration depend on Core Bluetooth callbacks and system scheduling. Force-quit, revoked permission, disabled Bluetooth and power loss interrupt collection. This checkout's native background delivery is unverified.
