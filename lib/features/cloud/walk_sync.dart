import '../../storage/care_database.dart';
import 'repository.dart';

/// The committed walk is the durable queue entry. Only acknowledge after
/// Firestore confirms the write. Its stable document ID makes replay safe.
class WalkSync {
  WalkSync(this.db, this.remote, this.uid);
  final CareDatabase db;
  final CareRepository remote;
  final String uid;
  bool _running = false, closed = false;
  Future<void> flush() async {
    if (_running || closed) return;
    _running = true;
    try {
      while (!closed) {
        final rows = await db.customSelect("""
          SELECT w.* FROM walk_sessions w WHERE NOT EXISTS
          (SELECT 1 FROM preferences p WHERE p.key='sent_walk/' || w.id)
          ORDER BY started_at,id LIMIT 32
        """).get();
        if (rows.isEmpty) return;
        for (final row in rows) {
          if (closed) return;
          final walk = db.walkSessions.map(row.data);
          await remote.send(uid, walk);
          if (closed) return;
          await db.setPreference('sent_walk/${walk.id}', '1');
        }
      }
    } finally {
      _running = false;
    }
  }
}
