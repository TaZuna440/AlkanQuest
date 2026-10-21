import 'package:drift/drift.dart';

import '../database/app_database.dart';

class ProfileRepository {
  static const String singletonId = 'profile_singleton';
  final AppDatabase _db;

  ProfileRepository(this._db);

  Future<UserProfile?> get() =>
      (_db.select(_db.userProfiles)..where((t) => t.id.equals(singletonId)))
          .getSingleOrNull();

  /// Live stream of the singleton profile (emits on every update).
  Stream<UserProfile?> watch() =>
      (_db.select(_db.userProfiles)..where((t) => t.id.equals(singletonId)))
          .watchSingleOrNull();

  Future<UserProfile> getOrCreate() async {
    final existing = await get();
    if (existing != null) return existing;
    await _db.into(_db.userProfiles).insert(
          UserProfilesCompanion.insert(
            id: singletonId,
            displayName: 'HUNTER',
            createdAt: DateTime.now().toUtc(),
          ),
        );
    return (await get())!;
  }

  Future<void> save(UserProfile profile) =>
      _db.update(_db.userProfiles).replace(profile);

  Future<void> updateDisplayName(String name) =>
      (_db.update(_db.userProfiles)..where((t) => t.id.equals(singletonId)))
          .write(UserProfilesCompanion(displayName: Value(name)));

  Future<void> updateLocale(String locale) =>
      (_db.update(_db.userProfiles)..where((t) => t.id.equals(singletonId)))
          .write(UserProfilesCompanion(locale: Value(locale)));

  Future<void> updateSystemVoice(bool enabled) =>
      (_db.update(_db.userProfiles)..where((t) => t.id.equals(singletonId)))
          .write(
              UserProfilesCompanion(systemVoiceEnabled: Value(enabled)));

  Future<void> updateNotificationsEnabled(bool enabled) =>
      (_db.update(_db.userProfiles)..where((t) => t.id.equals(singletonId)))
          .write(
              UserProfilesCompanion(notificationsEnabled: Value(enabled)));

  Future<void> updateReminderTime(String hhmm) =>
      (_db.update(_db.userProfiles)..where((t) => t.id.equals(singletonId)))
          .write(UserProfilesCompanion(dailyReminderTime: Value(hhmm)));

  Future<void> recordNotificationDecline() async {
    final profile = await getOrCreate();
    await (_db.update(_db.userProfiles)
          ..where((t) => t.id.equals(singletonId)))
        .write(
      UserProfilesCompanion(
        notificationDeclineCount:
            Value(profile.notificationDeclineCount + 1),
        lastNotificationPrompt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> markOnboardingComplete() =>
      (_db.update(_db.userProfiles)..where((t) => t.id.equals(singletonId)))
          .write(const UserProfilesCompanion(onboardingComplete: Value(true)));

  Future<bool> isOnboardingComplete() async {
    final profile = await get();
    return profile?.onboardingComplete ?? false;
  }
}
