import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services.dart';
import '../domain/cane_service.dart';

final caneServiceProvider = Provider<CaneService>((ref) {
  const deviceId = String.fromEnvironment('CARE_BLE_DEVICE_ID');
  final CaneService service = deviceId.isEmpty
      ? MockCaneService()
      : (BleCaneService()..selectedDevice = deviceId);
  ref.onDispose(service.dispose);
  return service;
});
