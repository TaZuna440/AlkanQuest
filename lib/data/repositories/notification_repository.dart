import 'package:drift/drift.dart';

import '../database/app_database.dart';

/// Tiny repository for the notification log table.
class NotificationRepository {
  final AppDatabase _db;

  NotificationRepository(this._db);

  Future<void> log({
    required String id,
    required String type,
    String? challengeId,
  }) =>
      _db.into(_db.notificationLogs).insert(
            NotificationLogsCompanion.insert(
              id: id,
              type: type,
              challengeId: Value(challengeId),
              sentAt: DateTime.now().toUtc(),
            ),
          );

  Future<List<NotificationLog>> recent({int limit = 50}) =>
      (_db.select(_db.notificationLogs)
            ..orderBy([(t) => OrderingTerm.desc(t.sentAt)])
            ..limit(limit))
          .get();
}
