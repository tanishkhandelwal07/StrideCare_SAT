import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'care_database.g.dart';

@DriftDatabase(include: {'schema.drift'})
class CareDatabase extends _$CareDatabase {
  CareDatabase(super.executor);

  factory CareDatabase.local() => CareDatabase(
    driftDatabase(
      name: 'stridecare',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    ),
  );

  Future<void> setPreference(String key, String value) => customStatement(
    'INSERT OR REPLACE INTO preferences(key,value) VALUES(?,?)',
    [key, value],
  );
  Future<String?> preference(String key) async => (await customSelect(
    'SELECT value FROM preferences WHERE key = ?',
    variables: [Variable(key)],
  ).getSingleOrNull())?.read<String>('value');

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (_, _, _) async {},
    beforeOpen: (_) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await customStatement(
        'CREATE TABLE IF NOT EXISTS preferences(key TEXT PRIMARY KEY,value TEXT NOT NULL)',
      );
    },
  );
}

final databaseProvider = Provider<CareDatabase>((ref) {
  final database = CareDatabase.local();
  ref.onDispose(database.close);
  return database;
});
