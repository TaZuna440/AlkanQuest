import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(userProfiles, userProfiles.onboardingComplete);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'ipon_system.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
