import 'package:drift/drift.dart';

class NotificationLogs extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  TextColumn get challengeId => text().nullable()();
  DateTimeColumn get sentAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
