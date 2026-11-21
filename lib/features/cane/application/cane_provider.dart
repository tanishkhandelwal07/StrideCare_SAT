import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services.dart';
import '../domain/cane_service.dart';

final caneServiceProvider = Provider<CaneService>((ref) {
  final service = MockCaneService();
  ref.onDispose(service.dispose);
  return service;
});
