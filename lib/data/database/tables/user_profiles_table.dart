import 'package:drift/drift.dart';

class UserProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get displayName => text().withLength(min: 1, max: 24)();
  TextColumn get avatarPath => text().nullable()();
  IntColumn get totalXp => integer().withDefault(const Constant(0))();
  IntColumn get level => integer().withDefault(const Constant(1))();
  TextColumn get rank => text().withDefault(const Constant('E'))();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  TextColumn get unlockedAchievementIds =>
      text().withDefault(const Constant(''))();
  TextColumn get locale => text().withDefault(const Constant('en'))();
  BoolColumn get notificationsEnabled =>
      boolean().withDefault(const Constant(false))();
  TextColumn get dailyReminderTime =>
      text().withDefault(const Constant('20:00'))();
  IntColumn get notificationDeclineCount =>
      integer().withDefault(const Constant(0))();
  DateTimeColumn get lastNotificationPrompt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
