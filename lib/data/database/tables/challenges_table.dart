import 'package:drift/drift.dart';

class Challenges extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 40)();
  TextColumn get description => text().nullable()();
  IntColumn get targetAmountCents => integer()();
  IntColumn get currentAmountCents => integer().withDefault(const Constant(0))();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get targetDate => dateTime()();
  TextColumn get frequency => text()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  TextColumn get colorHex => text().withDefault(const Constant('#B026FF'))();
  TextColumn get iconId => text().withDefault(const Constant('piggy_bank'))();
  BoolColumn get milestone25Notified => boolean().withDefault(const Constant(false))();
  BoolColumn get milestone50Notified => boolean().withDefault(const Constant(false))();
  BoolColumn get milestone75Notified => boolean().withDefault(const Constant(false))();
  BoolColumn get nearCompletionNotified => boolean().withDefault(const Constant(false))();
  BoolColumn get completionNotified => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
