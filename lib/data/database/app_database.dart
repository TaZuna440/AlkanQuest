import 'package:drift/drift.dart';

import 'connection/connection.dart'
    if (dart.library.io) 'connection/connection_native.dart'
    if (dart.library.js_interop) 'connection/connection_web.dart';

import 'tables/challenges_table.dart';
import 'tables/savings_records_table.dart';
import 'tables/user_profiles_table.dart';
import 'tables/achievements_table.dart';
import 'tables/notification_logs_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Challenges,
  SavingsRecords,
  UserProfiles,
  Achievements,
  NotificationLogs,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(userProfiles, userProfiles.onboardingComplete);
          }
          if (from < 3) {
            await m.addColumn(challenges, challenges.iconPath);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}
